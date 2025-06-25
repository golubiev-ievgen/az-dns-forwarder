FROM alpine:3.12

LABEL maintainer="golubev.evgenii@gmail.com" \
org.label-schema.vcs-url="https://github.com/golubiev-ievgen/az-dns-forwarder"

# Add configuration files
ADD named.conf /etc/bind/
ADD entrypoint.sh /entrypoint.sh

# Install BIND and prepare environment
RUN apk add --no-cache bind bind-tools && \
    chmod +x /entrypoint.sh && \
    mkdir -p /etc/bind/zones && \
    rm -rf /var/cache/apk/*

EXPOSE 53/udp

ENTRYPOINT ["/entrypoint.sh"]