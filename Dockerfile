#
# Dockerfile to generate an report of ABI/API changes of two library versions.
#
# Building Docker Image:
#
#   docker build -t docker-abicc:1.0 .
#
# Execute Docker Image:
#
#   docker run -v /my-host-directory:/data --rm -it docker-abicc:1.0
#

FROM ubuntu:20.04

#
# environment variables
#

ENV SOURCE_DIR=/source
ENV INSTALL_DIR=/usr/local
ENV DATA_DIR=/data

#
# update system and install dependencies
#

RUN apt-get -y update

RUN apt-get -y install -y --no-install-recommends \
  ca-certificates \
  git \
  elfutils \
  libelf-dev \
  autoconf \
  automake \
  pkg-config \
  make \
  g++

#
# prepare directory for git repositories
#

RUN mkdir -p ${SOURCE_DIR}

#
# install abi-dumper
#

RUN git clone https://github.com/lvc/abi-dumper.git ${SOURCE_DIR}/abi-dumper

WORKDIR ${SOURCE_DIR}/abi-dumper

RUN git checkout tags/1.2 -b release

RUN make install prefix=${INSTALL_DIR}

#
# install vtable-dumper
#

RUN git clone https://github.com/lvc/vtable-dumper.git ${SOURCE_DIR}/vtable-dumper

WORKDIR ${SOURCE_DIR}/vtable-dumper

RUN git checkout tags/1.2 -b release

RUN make install prefix=${INSTALL_DIR}

#
#
#

RUN git clone https://github.com/lvc/abi-compliance-checker.git ${SOURCE_DIR}/abi-compliance-checker

WORKDIR ${SOURCE_DIR}/abi-compliance-checker

RUN git checkout tags/2.3 -b release

RUN make install prefix=${INSTALL_DIR}

#
# add 'generate_report.sh' script at installation directory
#

ADD generate_report.sh ${INSTALL_DIR}/bin

#
# finalize
#

ADD entry.sh ${INSTALL_DIR}/bin

ENTRYPOINT entry.sh

WORKDIR ${DATA_DIR}
