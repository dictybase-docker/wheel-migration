FROM dictybase/postgres:9.3
MAINTAINER Siddhartha Basu<siddhartha-basu@northwestern.edu>
RUN apt-get update \
    && apt-get -y install curl \
    && rm -rf /var/lib/apt/lists/* 

RUN mkdir -p /docker-entrypoint-initdb.d && mkdir -p /config
COPY postgresql.conf /
COPY *.conf /config/
COPY create_chado_user.sh /docker-entrypoint-initdb.d/ 
