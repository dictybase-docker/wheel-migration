FROM alpine
MAINTAINER Siddhartha Basu<siddhartha-basu@northwestern.edu>

RUN set -ex \
    && apk add --no-cache --virtual curl \
    && apk add --no-cache --virtual bash \
    && apk add --no-cache --virtual tzdata
ENV TZ America/Chicago
COPY app.sh /usr/local/bin/
CMD ["app.sh"]
