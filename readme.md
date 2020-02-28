### docker-build

How to check that keys were set:
```
docker run -e "NEWRELIC_APPNAME=hey" -e "NEWRELIC_LICENSE=ho" oliverlundquist/php74 cat /usr/local/etc/php/conf.d/newrelic.ini | grep -E "appname|license"
```
