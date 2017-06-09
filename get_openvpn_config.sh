#!/bin/sh

docker run -v dockerbuild_autovpn-volume:/autovpn --name helper busybox true
# docker cp helper:/autovpn/us-east-1_aws_vpn.ovpn ./us-east-1_aws_vpn_$(date +%Y-%m-%d_%H%M%S).ovpn
docker cp helper:/autovpn/us-east-1_aws_vpn.ovpn .
docker rm helper > /dev/null 2>&1
