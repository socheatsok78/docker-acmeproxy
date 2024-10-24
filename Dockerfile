ARG OS=ubuntu
ARG S6_OVERLAY_VERSION=v3.2.0.0

FROM socheatsok78/s6-overlay-distribution:${S6_OVERLAY_VERSION} AS s6-overlay-distribution

FROM alpine
RUN --mount=type=bind,source=packages.alpine,target=/tmp/packages.alpine \
    apk add --no-cache $(cat /tmp/packages.alpine)
RUN addgroup acmeproxy && \
    adduser -D -G acmeproxy acmeproxy
ENV HOME=/home/acmeproxy
WORKDIR /home/acmeproxy

ADD https://raw.githubusercontent.com/madcamel/acmeproxy.pl/refs/heads/main/acmeproxy.pl /acmeproxy.pl
ADD https://raw.githubusercontent.com/socheatsok78/s6-overlay-installer/refs/heads/main/hacks/init-shim /init-shim
RUN chmod +x /init-shim && \
    chmod 644 /acmeproxy.pl

COPY --link --from=s6-overlay-distribution / /
ADD rootfs /
ENTRYPOINT ["/init-shim"]
CMD ["/docker-entrypoint.sh"]

VOLUME ["/home/acmeproxy/.acme.sh", "/data"]
EXPOSE 9443
