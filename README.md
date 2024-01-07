[![GitHub Tag](https://github.com/ivan-danov/xdocker-make/actions/workflows/build_deb.yml/badge.svg)](https://github.com/ivan-danov/xdocker-make/releases) \
[![Docker Pulls](https://img.shields.io/docker/pulls/xdockermake/vekatech-vkrzv2l-bookworm-devel?label=Vekatech%20%20VK-RZV2L%20v2%20Debian%20Bookworm%20docker%20pulls)](https://hub.docker.com/r/xdockermake/vekatech-vkrzv2l-bookworm-devel) \
[![Docker Pulls](https://img.shields.io/docker/pulls/xdockermake/pi-jammy-devel?label=RaspberryPi%20Ubuntu%20Jammy%20docker%20pulls)](https://hub.docker.com/rxdockermake/pi-jammy-devel)
[![Docker Pulls](https://img.shields.io/docker/pulls/xdockermake/pi-bullseye-devel?label=RaspberryPi%20Debian%20Bullseye%20docker%20pulls)](https://hub.docker.com/r/xdockermake/pi-bullseye-devel)
[![Docker Pulls](https://img.shields.io/docker/pulls/xdockermake/pi-bookworm-devel?label=RaspberryPi%20Debian%20Bookworm%20docker%20pulls)](https://hub.docker.com/r/xdockermake/pi-bookworm-devel) \
[![Docker Pulls](https://img.shields.io/docker/pulls/xdockermake/libre-jammy-devel?label=Libre%20Le%20Potato%20AML-S905X-CC%20Ubuntu%20Jammy%20docker%20pulls)](https://hub.docker.com/r/xdockermake/libre-jammy-devel) \
[![Docker Pulls](https://img.shields.io/docker/pulls/xdockermake/precise-devel?label=Ubuntu%20Precise%20docker%20pulls)](https://hub.docker.com/r/xdockermake/precise-devel)
[![Docker Pulls](https://img.shields.io/docker/pulls/xdockermake/xenial-devel?label=Ubuntu%20Xenial%20docker%20pulls)](https://hub.docker.com/r/xdockermake/xenial-devel)
[![Docker Pulls](https://img.shields.io/docker/pulls/xdockermake/bionic-devel?label=Ubuntu%20Bionic%20docker%20pulls)](https://hub.docker.com/r/xdockermake/bionic-devel)
[![Docker Pulls](https://img.shields.io/docker/pulls/xdockermake/focal-devel?label=Ubuntu%20Focal%20docker%20pulls)](https://hub.docker.com/r/xdockermake/focal-devel)
[![Docker Pulls](https://img.shields.io/docker/pulls/xdockermake/jammy-devel?label=Ubuntu%20Jammy%20docker%20pulls)](https://hub.docker.com/r/xdockermake/jammy-devel)
[![Docker Pulls](https://img.shields.io/docker/pulls/xdockermake/noble-devel?label=Ubuntu%20Noble%20docker%20pulls)](https://hub.docker.com/r/xdockermake/noble-devel) \
[![Docker Pulls](https://img.shields.io/docker/pulls/xdockermake/jammy-mysql-cluster-devel?label=Ubuntu%20Jammy%20mysql%20cluster%20docker%20pulls)](https://hub.docker.com/rxdockermake/jammy-mysql-cluster-devel)

# xdocker-make

Scripts to exec programs in docker container

## Install from deb package
Download xdocker-make deb package from https://github.com/ivan-danov/xdocker-make/releases/latest

```
curl -fsSL $(curl -s "https://api.github.com/repos/ivan-danov/xdocker-make/releases/latest"|grep "browser_download_url.*deb"|cut -d ':' -f 2,3|tr -d \"|xargs) -o ./xdocker-make.deb
```

Install xdocker-make deb package
```
sudo apt install ./xdocker-make.deb
```

## Install from source
```
# clone repository
git clone git@github.com:ivan-danov/xdocker-make.git

# go to directory
cd xdocker-make

# create deb package
make deb

# install deb package
sudo apt install ./xdocker-make_*_all.deb
```

## Create custom docker image

1. Create config file, see examples in /usr/share/doc/xdocker-make/examples

2. Create docker image

```
xdocker-create <config file>
```

3. View generated docker image

```
docker images
```

## View generated images in docker hub

[https://hub.docker.com/u/xdockermake](https://hub.docker.com/u/xdockermake)

or download list of images

```
curl -s -X GET "https://hub.docker.com/v2/repositories/xdockermake/"|jq -r '.results|.[]|.name'
```

## Pull image from docker hub

```
docker pull xdockermake/${image_name}:latest
```

## Pull all images from docker hub

```
for image_name in $(curl -s -X GET "https://hub.docker.com/v2/repositories/xdockermake/"|jq -r '.results|.[]|.name'); do
        docker pull xdockermake/${image_name}:latest
done
```

## Create aliases for installed images

```
for di in $(docker images --filter=reference='xdockermake/*:latest' --format "table {{.Repository}}"|grep -v REPOSITORY); do
        did=${di#xdockermake/}
        alias xdocker-make-${did%-devel}="~/src/xdocker-make/xdocker-make ${di}:latest"
done
```

## Use docker image to compile your program

1. Go to program directory
2. Exec make in docker image
```
# xdocker-make <docker image> command arguments
# or use created alias
# xdocker-make-<docker image> command arguments
# example:
xdocker-make xdockermake/jammy-devel:latest make

```

## Included examples

### For Vekatech VK-RZV2L v2 board (https://vekatech.com/products2.php?id=2)

#### Debian Bookworm for Vekatech VK-RZV2L v2 board
[vekatech-vkrzv2l-bookworm-dev.conf](examples/vekatech-vkrzv2l-bookworm-dev.conf)

### For RaspberryPi board
#### Debian Bookworm for RaspberryPi
[pi-bookworm-dev.conf](examples/pi-bookworm-dev.conf)

#### Debian Bullseye for RaspberryPi
[pi-bullseye-dev.conf](examples/pi-bullseye-dev.conf)

#### Ubuntu Jammy for RaspberryPi
[pi-jammy-dev.conf](examples/pi-jammy-dev.conf)

### Ubuntu Jammy for Libre Le Potato AML-S905X-CC
### https://libre.computer/products/aml-s905x-cc/
[libre-jammy-dev.conf](examples/libre-jammy-dev.conf)

### Ubuntu amd64 versions
[precise-dev.conf](examples/precise-dev.conf) \
[xenial-dev.conf](examples/xenial-dev.conf) \
[bionic-dev.conf](examples/bionic-dev.conf) \
[focal-dev.conf](examples/focal-dev.conf) \
[jammy-dev.conf](examples/jammy-dev.conf) \
[noble-dev.conf](examples/noble-dev.conf)

### Ubuntu jammy with mysql cluster libs
[jammy-mysql-cluster-dev.conf](examples/jammy-mysql-cluster-dev.conf)

