#!/bin/bash

./deploy_php.sh

make deploy-nginx
make deploy-logstash
make deploy-aws-cli
make deploy-selenium-chrome-node
