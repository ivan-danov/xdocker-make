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

DOCKER_BUILD_USER=xdocker
DOCKER_UID=$1
DOCKER_GID=$2
PROJECT_SRC_DOCKER_DIR=$3
shift 3

chown "${DOCKER_UID}"."${DOCKER_GID}" /home/${DOCKER_BUILD_USER}

addgroup --quiet --gid "${DOCKER_GID}" ${DOCKER_BUILD_USER}
adduser --quiet --home /home/${DOCKER_BUILD_USER} --uid "${DOCKER_UID}" \
  --ingroup ${DOCKER_BUILD_USER} \
  --shell /bin/bash --disabled-password --gecos 'compile user' ${DOCKER_BUILD_USER}

adduser --quiet ${DOCKER_BUILD_USER} sudo &>/dev/null

CMD=$*

su -l ${DOCKER_BUILD_USER} << EOF
# for makefiles
export MCPU=1
export V=0
export SHOW_LESS_LINES=yes
export SHOW_LINKING_LINES=yes
export ENABLE_DEPENDANCY=yes
export BEERSYM='🍺 '

cd "${PROJECT_SRC_DOCKER_DIR}"
echo "Exec on $(lsb_release -s -d)"
${CMD}
EOF
