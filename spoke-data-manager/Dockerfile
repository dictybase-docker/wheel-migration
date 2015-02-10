FROM dictybase/golang:1.4.1
MAINTAINER Siddhartha Basu<siddhartha-basu@northwestern.edu>

RUN mkdir -p /usr/src/downloader
COPY runner.go /usr/src/downloader/
WORKDIR /usr/src/downloader
CMD ["/usr/src/go/bin/go", "run", "runner.go"]
