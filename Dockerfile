FROM alpine:latest
LABEL maintainer "L3msh0@gmail.com"

ARG SKIPFISH_VERSION=2.10b

RUN \
  apk --no-cache add openssl pcre libidn && \
  apk --no-cache --virtual .build-tools add libc-dev make gcc openssl-dev pcre-dev libidn-dev && \
  mkdir /opt && \
  cd /opt && \
  wget "https://github.com/l3msh0/skipfish/archive/${SKIPFISH_VERSION}.tar.gz" && \
  tar zxf ${SKIPFISH_VERSION}.tar.gz && \
  rm -f ${SKIPFISH_VERSION}.tar.gz && \
  ln -s skipfish-${SKIPFISH_VERSION} skipfish && \
  cd skipfish && \
  make && \
  mkdir /work && \
  apk del --purge .build-tools

VOLUME /work
WORKDIR /opt/skipfish

ENTRYPOINT ["/opt/skipfish/skipfish"]

CMD ["-h"]