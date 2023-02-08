### docker-build


#### Setup
```
docker context create multi-arch-build
docker buildx create --name builder --use multi-arch-build
docker buildx inspect --bootstrap
```

#### Build
```
docker buildx bake --print
docker buildx bake --push
```

#### When introducing new PHP versions
```
docker buildx bake --print php7 php8
docker buildx bake --push php7 php8
```
