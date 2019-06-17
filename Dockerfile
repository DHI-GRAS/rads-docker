FROM ubuntu:18.04

MAINTAINER Jonas Sølvsteen josl@dhigroup.com

USER root

VOLUME ["/rads"]

WORKDIR /app

RUN mkdir /rads/data

RUN \
        apt-get update && \
        apt-get install -y curl && \
        apt-get install -y libnetcdf-dev libnetcdff-dev netcdf-bin gfortran
RUN \
        curl -sL https://github.com/remkos/rads/archive/v4.3.4.tar.gz | tar xvz && \
        cd rads-4.3.4 && \
        ./configure --prefix=/usr/local --datadir=/rads/data && \
        make && \
        make install

WORKDIR /rads

ENTRYPOINT ["rads2nc"]
CMD ["--help"]
