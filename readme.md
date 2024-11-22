### docker-build

#### Setup (create Docker context and buildx build instance)
```
docker context create multi-arch-build
docker buildx create --name builder --use multi-arch-build
docker buildx inspect --bootstrap (if builder is already created, run "docker buildx use builder" then use this command to start it if stopped, switch back by running "docker buildx use desktop-linux" and "docker buildx stop builder")
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
docker buildx bake --print php7 php8
docker buildx bake --push php7 php8
```

### Inspect Docker manifest on DockerHub
```
docker manifest inspect <image>:<tag>
```
