[![GitHub Tag](https://github.com/ivan-danov/xdocker-make/actions/workflows/build_deb.yml/badge.svg)](https://github.com/ivan-danov/xdocker-make/releases)

[![Docker Pulls](https://img.shields.io/docker/pulls/xdockermake/precise-devel?label=Precise%20docker%20pulls)](https://hub.docker.com/r/xdockermake/precise-devel)
[![Docker Pulls](https://img.shields.io/docker/pulls/xdockermake/xenial-devel?label=Xenial%20docker%20pulls)](https://hub.docker.com/r/xdockermake/xenial-devel)
[![Docker Pulls](https://img.shields.io/docker/pulls/xdockermake/bionic-devel?label=Bionic%20docker%20pulls)](https://hub.docker.com/r/xdockermake/bionic-devel)
[![Docker Pulls](https://img.shields.io/docker/pulls/xdockermake/focal-devel?label=Focal%20docker%20pulls)](https://hub.docker.com/r/xdockermake/focal-devel)
[![Docker Pulls](https://img.shields.io/docker/pulls/xdockermake/jammy-devel?label=Jammy%20docker%20pulls)](https://hub.docker.com/r/xdockermake/jammy-devel)
[![Docker Pulls](https://img.shields.io/docker/pulls/xdockermake/jammy-mysql-cluster-devel?label=Jammy%20mysql%20cluster%20docker%20pulls)](https://hub.docker.com/rxdockermake/jammy-mysql-cluster-devel)
[![Docker Pulls](https://img.shields.io/docker/pulls/xdockermake/pi-jammy-devel?label=RaspberryPi%20Jammy%20docker%20pulls)](https://hub.docker.com/rxdockermake/pi-jammy-devel)
[![Docker Pulls](https://img.shields.io/docker/pulls/xdockermake/pi-bullseye-devel?label=RaspberryPi%20Bullseye%20docker%20pulls)](https://hub.docker.com/r/xdockermake/pi-bullseye-devel)

# xdocker-make

## get list of generated images

```
curl -s -X GET "https://hub.docker.com/v2/repositories/xdockermake/"|jq -r '.results|.[]|.name'
```

## pull image

```
docker pull xdockermake/${image_name}:latest
```

## pull all images

```
for image_name in $(curl -s -X GET "https://hub.docker.com/v2/repositories/xdockermake/"|jq -r '.results|.[]|.name'); do
        echo docker pull xdockermake/${image_name}:latest
done
```

## create aliases for installed images

```
for di in $(docker images --filter=reference='xdockermake/*:latest' --format "table {{.Repository}}"|grep -v REPOSITORY); do
        did=${di#xdockermake/}
        alias xdocker-make-${did%-devel}="~/src/xdocker-make/xdocker-make ${di}:latest"
done
```
