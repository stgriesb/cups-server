FROM debian:trixie-slim

RUN apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    cups avahi-daemon printer-driver-cups-pdf cups-ipp-utils && \
    apt-get clean && find /var/lib/apt/lists -type f -delete

COPY /avahi/avahi-daemon /etc/init.d/
COPY /conf/*.conf /tmp/
COPY docker-entrypoint.sh /tmp/

RUN chmod +x /tmp/docker-entrypoint.sh

EXPOSE 631

VOLUME ["/etc/cups"]
VOLUME ["/var/spool"]
VOLUME ["/var/log/cups"]
VOLUME ["/var/cache/cups"]

ENTRYPOINT ["/tmp/docker-entrypoint.sh"]
