[![GitHub Tag](https://github.com/ivan-danov/xdocker-make/actions/workflows/build_deb.yml/badge.svg)](https://github.com/ivan-danov/xdocker-make/releases)

[![Docker Pulls](https://img.shields.io/docker/pulls/xdockermake/precise-devel?label=Precise%20docker%20pulls)](https://hub.docker.com/repository/docker/xdockermake/precise-devel/general)
[![Docker Pulls](https://img.shields.io/docker/pulls/xdockermake/xenial-devel?label=Xenial%20docker%20pulls)](https://hub.docker.com/repository/docker/xdockermake/xenial-devel/general)
[![Docker Pulls](https://img.shields.io/docker/pulls/xdockermake/bionic-devel?label=Bionic%20docker%20pulls)](https://hub.docker.com/repository/docker/xdockermake/bionic-devel/general)
[![Docker Pulls](https://img.shields.io/docker/pulls/xdockermake/focal-devel?label=Focal%20docker%20pulls)](https://hub.docker.com/repository/docker/xdockermake/focal-devel/general)
[![Docker Pulls](https://img.shields.io/docker/pulls/xdockermake/jammy-devel?label=Jammy%20docker%20pulls)](https://hub.docker.com/repository/docker/xdockermake/jammy-devel/general)

# xdocker-make

```
for di in $(docker images --filter=reference='xdockermake/*:latest' --format "table {{.Repository}}"|grep -v REPOSITORY); do
        did=${di#xdockermake/}
        alias xdocker-make-${did%-devel}="~/src/xdocker-make/xdocker-make ${di}:latest"
done
```
