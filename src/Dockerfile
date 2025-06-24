FROM alpine:3.12

LABEL maintainer="golubev.evgenii@gmail.com" \
org.label-schema.vcs-url="https://github.com/golubiev-ievgen/az-dns-forwarder"

ADD named.conf /etc/bind/

RUN apk add --no-cache bind && \
    rm -rf /var/cache/apk/*

EXPOSE 53/udp

ENTRYPOINT ["/usr/sbin/named", "-f", "-g"]
