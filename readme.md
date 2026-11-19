### docker-build

#### Setup (create Docker context and buildx build instance)
```
docker context create multi-arch-build
docker buildx create --name builder --use multi-arch-build
docker buildx inspect --bootstrap (if builder is already created, run "docker buildx use builder" then use this command (docker buildx inspect --bootstrap) to start the builder if stopped, switch back by running "docker buildx use desktop-linux" and "docker buildx stop builder", to see all builders use "docker buildx ls")
```

#### Build
```
docker buildx bake --print
docker buildx bake --push
```

### Build w/o Provenance and SBOM
```
docker buildx bake --push --provenance=false --sbom=false
```

#### When introducing new PHP versions
```
docker buildx bake --print php8 php8-opcache
docker buildx bake --push php8 php8-opcache
```

### Inspect Docker manifest on DockerHub
```
docker manifest inspect <image>:<tag>
```

### Docker Hub or AWS ECR
Image versions are set in `.env` and used for both registries. Which registry the images are pushed to depends on the compose files passed to `docker buildx bake`:

- `docker-compose.yml` only (the default): pushes to Docker Hub
- `docker-compose.yml` + `docker-compose.ecr.yml`: pushes to AWS ECR, tagged with both the version from `.env` and `latest`

The child PHP images (`php8-opcache`, `php8-queue-worker`, `php8-xdebug`) build on top of the `php8` image from the same bake run, so the base image never needs to be pushed first.

#### Push to AWS ECR
`ECR_PREFIX` is the registry plus the repository namespace. The images are pushed to `<ECR_PREFIX>/php-base`, `/php`, `/php-queue-worker`, `/nginx` and `/logstash`, and these repositories need to exist in ECR.
```
export ECR_PREFIX=<account-id>.dkr.ecr.<region>.amazonaws.com/<namespace>
aws ecr get-login-password --region <region> | docker login --username AWS --password-stdin <account-id>.dkr.ecr.<region>.amazonaws.com
docker buildx bake -f docker-compose.yml -f docker-compose.ecr.yml --print php8 php8-opcache php8-queue-worker nginx logstash
docker buildx bake -f docker-compose.yml -f docker-compose.ecr.yml --push --pull --no-cache php8 php8-opcache php8-queue-worker nginx logstash
```
Always name the targets when pushing to ECR. Targets that aren't in `docker-compose.ecr.yml` keep their Docker Hub names.
