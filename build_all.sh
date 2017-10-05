#!/bin/bash

./build_php.sh

make build-nginx
make build-logstash
make build-aws-cli
make build-selenium-chrome-node
