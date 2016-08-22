##
# Environment Variables
##
NAMESPACE=oliverlundquist
TAG=latest
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
build:
	@echo "$(GREEN)Building Nginx$(RESET)"
	- @docker build -f build/nginx --force-rm=true --rm=true --no-cache --tag=$(NAMESPACE)/nginx:$(TAG) .
	@echo "$(GREEN)Building Nginx:$(RESET) Done ✓"
	@echo ""
	@echo "$(GREEN)Deploying Nginx$(RESET)"
	- @docker push $(NAMESPACE)/nginx:$(TAG)
	@echo "$(GREEN)Deploying Nginx:$(RESET) Done ✓"
	@echo ""
	@echo "$(GREEN)Building PHP7$(RESET)"
	- @docker build -f build/php7 --force-rm=true --rm=true --no-cache --tag=$(NAMESPACE)/php7:$(TAG) .
	@echo "$(GREEN)Building PHP7:$(RESET) Done ✓"
	@echo ""
	@echo "$(GREEN)Deploying PHP7$(RESET)"
	- @docker push $(NAMESPACE)/php7:$(TAG)
	@echo "$(GREEN)Deploying PHP7:$(RESET) Done ✓"

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
