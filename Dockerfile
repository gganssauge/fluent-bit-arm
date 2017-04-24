FROM hypriot/rpi-alpine-scratch:latest
MAINTAINER ganssauge@gmx.de
LABEL Description="Fluent Bit docker image for ARM" Version="1.1"

# Fluent Bit version
ENV FLB_MAJOR 0
ENV FLB_MINOR 11
ENV FLB_PATCH 3
ENV FLB_VERSION 0.11.3

ENV FLB_TAR https://github.com/fluent/fluent-bit/archive/v$FLB_VERSION.zip

RUN mkdir -p /fluent-bit/bin /fluent-bit/etc

RUN apk -q update \
    && apk -q add \
       build-base \
       cmake \
       linux-headers \
       openssl \
       wget \
    && cd /tmp && wget -q -O "fluent-bit-$FLB_VERSION.zip" --no-check-certificate $FLB_TAR \
    && unzip -q "fluent-bit-$FLB_VERSION" \
    && cd "/tmp/fluent-bit-$FLB_VERSION"/build/ \
    && cmake -DFLB_DEBUG=On -DFLB_TRACE=On -DFLB_JEMALLOC=On -DFLB_BUFFERING=On ../ \
    && cd "/tmp/fluent-bit-$FLB_VERSION"/build/ \
    && make \
    && install -s bin/fluent-bit /fluent-bit/bin/ \
    && apk del --purge -q \
       build-base \
       cmake \
       linux-headers \
       openssl \
       wget \
    && rm -rf /tmp/*

# Configuration files
COPY fluent-bit.conf /fluent-bit/etc/
COPY parsers.conf /fluent-bit/etc/

# Entry point
CMD ["/fluent-bit/bin/fluent-bit", "-c", "/fluent-bit/etc/fluent-bit.conf"]
