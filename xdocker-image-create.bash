#!/bin/bash

#*******************************************************************************
#*                                 xdocker-make                                *
#*-----------------------------------------------------------------------------*
#*                                                                             *
#* Copyright (c) 2022 Ivan Danov                                               *
#*                                                                             *
#* MIT License                                                                 *
#*                                                                             *
#* Permission is hereby granted, free of charge, to any person obtaining a     *
#* copy of this software and associated documentation files (the "Software"),  *
#* to deal in the Software without restriction, including without limitation   *
#* the rights to use, copy, modify, merge, publish, distribute, sublicense,    *
#* and/or sell copies of the Software, and to permit persons to whom the       *
#* Software is furnished to do so, subject to the following conditions:        *
#*                                                                             *
#* The above copyright notice and this permission notice shall be included     *
#* in all copies or substantial portions of the Software.                      *
#*                                                                             *
#* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS     *
#* OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, *
#* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE *
#* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER      *
#* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING     *
#* FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER         *
#* DEALINGS IN THE SOFTWARE.                                                   *
#*******************************************************************************

set -Eeuo pipefail

# shellcheck disable=SC2034
XDOCKER_MAKE_BASE_VERSION="1.0"
# shellcheck disable=SC2034
XDOCKER_MAKE_VERSION=development

echo "IMAGE_TYPE=${IMAGE_TYPE}"
echo "OS_DISTRO=${OS_DISTRO}"
echo "CONTAINER_NAME=${CONTAINER_NAME}"
echo "CONTAINER_VERSION=${CONTAINER_VERSION}"

export TAR_OPTS=${TAR_OPTS:-"-J"}
export TAR_EXT=${TAR_EXT:-".xz"}

if [ "${OLD_RELEASE_REPO}" -eq 1 ]; then
sed -i -re 's/([a-z]{2}\.)?archive.ubuntu.com|security.ubuntu.com/old-releases.ubuntu.com/g' /etc/apt/sources.list
fi

ln -fs "/usr/share/zoneinfo/${TIMEZONE_PATH}" /etc/localtime
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get -y install apt-utils vim lsb-release
apt-get install -y --no-install-recommends tzdata
apt-get -y upgrade || ${SKIP_ERRORS:=false}

if [ -n "${DEB_PACKAGES0:=}" ]; then
	# shellcheck disable=SC2086
	apt-get -y install ${DEB_PACKAGES0} || ${SKIP_ERRORS:=false}
	apt-get update
fi

if [ -n "${DEB_PACKAGES:=}" ]; then
	# shellcheck disable=SC2086
	apt-get -y install ${DEB_PACKAGES} || ${SKIP_ERRORS:=false}
fi

# sudo without password
echo "%sudo   ALL=(ALL:ALL) NOPASSWD:ALL" > /etc/sudoers

chmod 755 /xdocker-build-project.bash
chmod 6755 /usr/bin/sudo

echo "Clean"
apt-get -qq clean
rm -rf /var/lib/apt/lists/*
