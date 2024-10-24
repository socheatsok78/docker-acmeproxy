ARG S6_OVERLAY_VERSION=v3.2.0.0
FROM socheatsok78/s6-overlay-distribution:${S6_OVERLAY_VERSION} AS s6-overlay-distribution

FROM ubuntu
RUN --mount=type=bind,source=packages.debian,target=/tmp/packages.debian \
    export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    cat /tmp/packages.debian | xargs apt-get install -y --no-install-recommends

ADD https://raw.githubusercontent.com/madcamel/acmeproxy.pl/refs/heads/main/acmeproxy.pl /app/acmeproxy.pl
ADD https://raw.githubusercontent.com/socheatsok78/s6-overlay-installer/refs/heads/main/hacks/init-shim /init-shim
RUN chmod +x /init-shim /app/acmeproxy.pl

ENV HOME="/acme"
WORKDIR /acme

COPY --link --from=s6-overlay-distribution / /
ADD rootfs /
ENTRYPOINT ["/init-shim"]
CMD ["/docker-entrypoint.sh"]

VOLUME ["/acme", "/data"]
EXPOSE 9443
