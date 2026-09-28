#!/usr/bin/env bash
#
# Copy the latest built images from Docker Hub to AWS ECR, tagged as :latest.
#
# The source tags are resolved from docker-compose.yml + .env (via bake), so
# bumping a tag in .env is all that's needed to change what gets pushed.
# Images are copied registry-to-registry with "imagetools create", which keeps
# the multi-arch manifest (amd64 + arm64) intact without pulling anything locally.
#
# Usage:
#   ./push-ecr.sh <prefix>                # push all images to <prefix>/<repo>
#   ./push-ecr.sh <prefix> nginx php      # push only the given ECR repositories
#
# Env:
#   ECR_PREFIX                    # alternative to passing <prefix> as the first argument
#   AWS_REGION / AWS_PROFILE      # standard AWS CLI settings
#
set -euo pipefail

cd "$(dirname "$0")"

ECR_PREFIX="${ECR_PREFIX:-${1:-}}"
if [[ -z "${ECR_PREFIX}" ]]; then
    echo "Usage: $0 <prefix> [repo...]  (or set ECR_PREFIX)" >&2
    exit 1
fi

# Drop the prefix from the arguments when it was passed positionally
if [[ $# -gt 0 && "$1" == "${ECR_PREFIX}" ]]; then
    shift
fi

# ECR repository => bake target
declare -a MAPPING=(
    "logstash:logstash"
    "nginx:nginx"
    "php:php8-opcache"
    "php-queue-worker:php8-queue-worker"
)

REGION="${AWS_REGION:-$(aws configure get region)}"
ACCOUNT_ID="$(aws sts get-caller-identity --query Account --output text)"
REGISTRY="${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com"

echo "Logging in to ${REGISTRY}"
aws ecr get-login-password --region "${REGION}" \
    | docker login --username AWS --password-stdin "${REGISTRY}"

BAKE_JSON="$(docker buildx bake --print 2>/dev/null)"

for entry in "${MAPPING[@]}"; do
    repo="${entry%%:*}"
    target="${entry#*:}"

    # Skip repositories not requested on the command line
    if [[ $# -gt 0 && ! " $* " =~ " ${repo} " ]]; then
        echo "Skipping ${ECR_PREFIX}/${repo} (not requested)"
        continue
    fi

    source_image="$(jq -r --arg t "${target}" '.target[$t].tags[0]' <<< "${BAKE_JSON}")"
    destination="${REGISTRY}/${ECR_PREFIX}/${repo}"

    echo "Copying ${source_image} => ${destination}:latest"
    docker buildx imagetools create \
        --tag "${destination}:latest" \
        "${source_image}"
done
