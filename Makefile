##
# Environment Variables
##
NAMESPACE=oliverlundquist
TAG=latest
DUSK_TAG=1.0.0
NETWORK_NAME=mystore-api
REPO_PATH=~/repositories/mystoreno/mystore-api
NGINX_ID=`docker ps | grep $(NAMESPACE)/nginx:$(TAG) | cut -d ' ' -f1`
PHP_ID=`docker ps | grep $(NAMESPACE)/php7:$(TAG) | cut -d ' ' -f1`

##
# ANSI Escape Codes
##
ESCAPE=\033
RESET=$(ESCAPE)[0m
GREEN=$(ESCAPE)[32m
BOL=$(ESCAPE)[2K$(ESCAPE)[0G

##
# Commands
##
build-php:
	@echo ""
	@echo "$(GREEN)Building PHP7$(RESET)"
	- @sed \
		-i'.original' \
		-e '/INCLUDE PHP_INSTRUCTIONS/r./docker/build/includes/php_instructions' \
		-e '/INCLUDE PHP_OPCACHE_INSTRUCTIONS/r./docker/build/includes/php_opcache_instructions' \
		-e 's/INCLUDE PHP_INSTRUCTIONS//g' \
		-e 's/INCLUDE PHP_OPCACHE_INSTRUCTIONS//g' \
		docker/build/php7
	- @docker rmi -f $(NAMESPACE)/php7:$(TAG)
	- @docker build -f docker/build/php7 --force-rm=true --rm=true --no-cache --tag=$(NAMESPACE)/php7:$(TAG) .
	- @mv docker/build/php7.original docker/build/php7
	@echo "$(GREEN)Building PHP7:$(RESET) Done ✓"
	@echo ""

build-php-wordpress:
	@echo ""
	@echo "$(GREEN)Building PHP7 WordPress$(RESET)"
	- @sed \
		-i'.original' \
		-e '/INCLUDE PHP_INSTRUCTIONS/r./docker/build/includes/php_instructions' \
		-e '/INCLUDE PHP_OPCACHE_INSTRUCTIONS/r./docker/build/includes/php_opcache_instructions' \
		-e 's/INCLUDE PHP_INSTRUCTIONS//g' \
		-e 's/INCLUDE PHP_OPCACHE_INSTRUCTIONS//g' \
		docker/build/php7-wordpress
	- @docker rmi -f $(NAMESPACE)/php7-wordpress:$(TAG)
	- @docker build -f docker/build/php7-wordpress --force-rm=true --rm=true --no-cache --tag=$(NAMESPACE)/php7-wordpress:$(TAG) .
	- @mv docker/build/php7-wordpress.original docker/build/php7-wordpress
	@echo "$(GREEN)Building PHP7 WordPress:$(RESET) Done ✓"
	@echo ""

build-php-opcache:
	@echo ""
	@echo "$(GREEN)Building PHP7 Opcache$(RESET)"
	- @sed \
		-i'.original' \
		-e '/INCLUDE PHP_INSTRUCTIONS/r./docker/build/includes/php_instructions' \
		-e '/INCLUDE PHP_OPCACHE_INSTRUCTIONS/r./docker/build/includes/php_opcache_instructions' \
		-e 's/INCLUDE PHP_INSTRUCTIONS//g' \
		-e 's/INCLUDE PHP_OPCACHE_INSTRUCTIONS//g' \
		docker/build/php7-opcache
	- @docker rmi -f $(NAMESPACE)/php7-opcache:$(TAG)
	- @docker build -f docker/build/php7-opcache --force-rm=true --rm=true --no-cache --tag=$(NAMESPACE)/php7-opcache:$(TAG) .
	- @mv docker/build/php7-opcache.original docker/build/php7-opcache
	@echo "$(GREEN)Building PHP7 Opcache:$(RESET) Done ✓"
	@echo ""

build-php-xdebug:
	@echo ""
	@echo "$(GREEN)Building PHP7 XDebug$(RESET)"
	- @docker rmi -f $(NAMESPACE)/php7-xdebug:$(TAG)
	- @docker build -f docker/build/php7-xdebug --force-rm=true --rm=true --no-cache --tag=$(NAMESPACE)/php7-xdebug:$(TAG) .
	@echo "$(GREEN)Building PHP7 XDebug:$(RESET) Done ✓"
	@echo ""

build-php-webgrind:
	@echo ""
	@echo "$(GREEN)Building PHP7 Webgrind$(RESET)"
	- @docker rmi -f $(NAMESPACE)/php7-webgrind:$(TAG)
	- @docker build -f docker/build/php7-webgrind --force-rm=true --rm=true --no-cache --tag=$(NAMESPACE)/php7-webgrind:$(TAG) .
	@echo "$(GREEN)Building PHP7 Webgrind:$(RESET) Done ✓"
	@echo ""

build-php-dusk:
	@echo ""
	@echo "$(GREEN)Building PHP7 Dusk$(RESET)"
	- @docker rmi -f $(NAMESPACE)/php7-dusk:$(DUSK_TAG)
	- @docker build -f docker/build/php7-dusk --force-rm=true --rm=true --no-cache --tag=$(NAMESPACE)/php7-dusk:$(DUSK_TAG) .
	@echo "$(GREEN)Building PHP7 Dusk:$(RESET) Done ✓"
	@echo ""

build-php-queue-worker:
	@echo ""
	@echo "$(GREEN)Building PHP7 Queue Worker$(RESET)"
	- @docker rmi -f $(NAMESPACE)/php7-queue-worker:$(TAG)
	- @docker build -f docker/build/php7-queue-worker --force-rm=true --rm=true --no-cache --tag=$(NAMESPACE)/php7-queue-worker:$(TAG) .
	@echo "$(GREEN)Building PHP7 Queue Worker:$(RESET) Done ✓"
	@echo ""

build-php-wordpress-cache:
	@echo ""
	@echo "$(GREEN)Building PHP7 WordPress Cache$(RESET)"
	- @docker rmi -f $(NAMESPACE)/php7-wordpress-cache:$(TAG)
	- @docker build -f docker/build/php7-wordpress-cache --force-rm=true --rm=true --no-cache --tag=$(NAMESPACE)/php7-wordpress-cache:$(TAG) .
	@echo "$(GREEN)Building PHP7 WordPress Cache:$(RESET) Done ✓"
	@echo ""

build-nginx:
	@echo ""
	@echo "$(GREEN)Building Nginx$(RESET)"
	- @docker rmi -f $(NAMESPACE)/nginx:$(TAG)
	- @docker build -f docker/build/nginx --force-rm=true --rm=true --no-cache --tag=$(NAMESPACE)/nginx:$(TAG) .
	@echo "$(GREEN)Building Nginx:$(RESET) Done ✓"
	@echo ""

build-node-elixir:
	@echo ""
	@echo "$(GREEN)Building Node Elixir$(RESET)"
	- @docker rmi -f $(NAMESPACE)/node-elixir:$(TAG)
	- @docker build -f docker/build/node-elixir --force-rm=true --rm=true --no-cache --tag=$(NAMESPACE)/node-elixir:$(TAG) .
	@echo "$(GREEN)Building Node Elixir:$(RESET) Done ✓"
	@echo ""

build-logstash:
	@echo ""
	@echo "$(GREEN)Building Logstash$(RESET)"
	- @docker rmi -f $(NAMESPACE)/logstash:$(TAG)
	- @docker build -f docker/build/logstash --force-rm=true --rm=true --no-cache --tag=$(NAMESPACE)/logstash:$(TAG) .
	@echo "$(GREEN)Building Logstash:$(RESET) Done ✓"
	@echo ""

build-autovpn:
	@echo ""
	@echo "$(GREEN)Building AutoVPN$(RESET)"
	- @docker rmi -f $(NAMESPACE)/autovpn:$(TAG)
	- @docker build -f docker/build/autovpn --force-rm=true --rm=true --no-cache --tag=$(NAMESPACE)/autovpn:$(TAG) .
	@echo "$(GREEN)Building AutoVPN:$(RESET) Done ✓"
	@echo ""

build-aws-cli:
	@echo ""
	@echo "$(GREEN)Building AWS CLI$(RESET)"
	- @docker rmi -f $(NAMESPACE)/aws-cli:$(TAG)
	- @docker build -f docker/build/aws-cli --force-rm=true --rm=true --no-cache --tag=$(NAMESPACE)/aws-cli:$(TAG) .
	@echo "$(GREEN)Building AWS CLI:$(RESET) Done ✓"
	@echo ""

build-pusher-local-dev-server:
	@echo ""
	@echo "$(GREEN)Building Pusher Local Dev Server$(RESET)"
	- @docker rmi -f $(NAMESPACE)/pusher-local-dev-server:$(TAG)
	- @docker build -f docker/build/pusher-local-dev-server --force-rm=true --rm=true --no-cache --tag=$(NAMESPACE)/pusher-local-dev-server:$(TAG) .
	@echo "$(GREEN)Building Pusher Local Dev Server:$(RESET) Done ✓"
	@echo ""

build-selenium-chrome-node:
	@echo ""
	@echo "$(GREEN)Building Selenium Node$(RESET)"
	- @docker rmi -f $(NAMESPACE)/selenium-chrome-node:$(TAG)
	- @docker build -f docker/build/selenium-chrome-node --force-rm=true --rm=true --no-cache --tag=$(NAMESPACE)/selenium-chrome-node:$(TAG) .
	@echo "$(GREEN)Building Selenium Node:$(RESET) Done ✓"
	@echo ""

build-serverless:
	@echo ""
	@echo "$(GREEN)Building Serverless$(RESET)"
	- @docker rmi -f $(NAMESPACE)/serverless:$(TAG)
	- @docker build -f docker/build/serverless --force-rm=true --rm=true --no-cache --tag=$(NAMESPACE)/serverless:$(TAG) .
	@echo "$(GREEN)Building Serverless:$(RESET) Done ✓"
	@echo ""

deploy-php:
	@echo ""
	@echo "$(GREEN)Deploying PHP7$(RESET)"
	- @docker push $(NAMESPACE)/php7:$(TAG)
	@echo "$(GREEN)Deploying PHP7:$(RESET) Done ✓"
	@echo ""

deploy-php-wordpress:
	@echo ""
	@echo "$(GREEN)Deploying PHP7 WordPress$(RESET)"
	- @docker push $(NAMESPACE)/php7-wordpress:$(TAG)
	@echo "$(GREEN)Deploying PHP7 WordPress:$(RESET) Done ✓"
	@echo ""

deploy-php-opcache:
	@echo ""
	@echo "$(GREEN)Deploying PHP7 Opcache$(RESET)"
	- @docker push $(NAMESPACE)/php7-opcache:$(TAG)
	@echo "$(GREEN)Deploying PHP7 Opcache:$(RESET) Done ✓"
	@echo ""

deploy-php-xdebug:
	@echo ""
	@echo "$(GREEN)Deploying PHP7 XDebug$(RESET)"
	- @docker push $(NAMESPACE)/php7-xdebug:$(TAG)
	@echo "$(GREEN)Deploying PHP7 XDebug:$(RESET) Done ✓"
	@echo ""

deploy-php-webgrind:
	@echo ""
	@echo "$(GREEN)Deploying PHP7 Webgrind$(RESET)"
	- @docker push $(NAMESPACE)/php7-webgrind:$(TAG)
	@echo "$(GREEN)Deploying PHP7 Webgrind:$(RESET) Done ✓"
	@echo ""

deploy-php-dusk:
	@echo ""
	@echo "$(GREEN)Deploying PHP7 Dusk$(RESET)"
	- @docker push $(NAMESPACE)/php7-dusk:$(DUSK_TAG)
	@echo "$(GREEN)Deploying PHP7 Dusk:$(RESET) Done ✓"
	@echo ""

deploy-php-queue-worker:
	@echo ""
	@echo "$(GREEN)Deploying PHP7 Queue Worker$(RESET)"
	- @docker push $(NAMESPACE)/php7-queue-worker:$(TAG)
	@echo "$(GREEN)Deploying PHP7 Queue Worker:$(RESET) Done ✓"
	@echo ""

deploy-php-wordpress-cache:
	@echo ""
	@echo "$(GREEN)Deploying PHP7 WordPress Cache$(RESET)"
	- @docker push $(NAMESPACE)/php7-wordpress-cache:$(TAG)
	@echo "$(GREEN)Deploying PHP7 WordPress Cache:$(RESET) Done ✓"
	@echo ""

deploy-nginx:
	@echo ""
	@echo "$(GREEN)Deploying Nginx$(RESET)"
	- @docker push $(NAMESPACE)/nginx:$(TAG)
	@echo "$(GREEN)Deploying Nginx:$(RESET) Done ✓"
	@echo ""

deploy-node-elixir:
	@echo ""
	@echo "$(GREEN)Deploying Node Elixir$(RESET)"
	- @docker push $(NAMESPACE)/node-elixir:$(TAG)
	@echo "$(GREEN)Deploying Node Elixir:$(RESET) Done ✓"
	@echo ""

deploy-logstash:
	@echo ""
	@echo "$(GREEN)Deploying Logstash$(RESET)"
	- @docker push $(NAMESPACE)/logstash:$(TAG)
	@echo "$(GREEN)Deploying Logstash:$(RESET) Done ✓"
	@echo ""

deploy-aws-cli:
	@echo ""
	@echo "$(GREEN)Deploying AWS CLI$(RESET)"
	- @docker push $(NAMESPACE)/aws-cli:$(TAG)
	@echo "$(GREEN)Deploying AWS CLI:$(RESET) Done ✓"
	@echo ""

deploy-pusher-local-dev-server:
	@echo ""
	@echo "$(GREEN)Deploying Pusher Local Dev Server$(RESET)"
	- @docker push $(NAMESPACE)/pusher-local-dev-server:$(TAG)
	@echo "$(GREEN)Deploying Pusher Local Dev Server:$(RESET) Done ✓"
	@echo ""

deploy-selenium-chrome-node:
	@echo ""
	@echo "$(GREEN)Deploying Selenium Node$(RESET)"
	- @docker push $(NAMESPACE)/selenium-chrome-node:$(TAG)
	@echo "$(GREEN)Deploying Selenium Node:$(RESET) Done ✓"
	@echo ""

deploy-serverless:
	@echo ""
	@echo "$(GREEN)Deploying Serverless$(RESET)"
	- @docker push $(NAMESPACE)/serverless:$(TAG)
	@echo "$(GREEN)Deploying Serverless:$(RESET) Done ✓"
	@echo ""

run:
	@echo "$(GREEN)Creating Network$(RESET)"
	- @docker network create $(NETWORK_NAME) 2>/dev/null
	@echo "$(GREEN)Creating Network:$(RESET) Done ✓"
	@echo ""
	@echo "$(GREEN)Starting PHP7$(RESET)"
	- @docker run -d --net=$(NETWORK_NAME) --net-alias="php" -v $(REPO_PATH):/srv/www/mystore-api -p 9000:9000 $(NAMESPACE)/php7:$(TAG) 2>/dev/null
	@echo "$(GREEN)Starting PHP7:$(RESET) Done ✓"
	@echo ""
	@echo "$(GREEN)Starting Nginx$(RESET)"
	- @docker run -d --net=$(NETWORK_NAME) -v $(REPO_PATH):/srv/www/mystore-api -p 80:80 $(NAMESPACE)/nginx:$(TAG) 2>/dev/null
	@echo "$(GREEN)Starting Nginx:$(RESET) Done ✓"

stop:
	@echo "$(GREEN)Stopping PHP7$(RESET)"
	- @docker stop $(PHP_ID) 2>/dev/null
	@echo "$(GREEN)Stopping PHP7:$(RESET) Done ✓"
	@echo ""
	@echo "$(GREEN)Stopping Nginx$(RESET)"
	- @docker stop $(NGINX_ID) 2>/dev/null
	@echo "$(GREEN)Stopping Nginx:$(RESET) Done ✓"
	@echo ""
	@echo "$(GREEN)Removing Network$(RESET)"
	- @docker network rm $(NETWORK_NAME) 2>/dev/null
	@echo "$(GREEN)Removing Network:$(RESET) Done ✓"
