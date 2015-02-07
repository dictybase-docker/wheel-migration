FROM dictybase/perl:5.20 
MAINTAINER Siddhartha Basu<siddhartha-basu@northwestern.edu>

COPY run.sh /usr/src/chadosqitch/
RUN apt-get update && apt-get -y install postgresql-client && \
    cpanm -n DBD::Pg App::Sqitch && \
    mkdir -p /usr/src/chadosqitch && \
    chmod u+x /usr/src/chadosqitch/run.sh
ENV SQITCH_CONFIG /config/sqitch.conf
CMD ["/usr/src/chadosqitch/run.sh"]

