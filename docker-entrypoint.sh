#!/bin/bash
set -e
set -x

if ! id "$CUPS_ADMIN_USERNAME" >/dev/null 2>&1; then
    useradd -m -G lpadmin -s /usr/sbin/nologin "$CUPS_ADMIN_USERNAME"
    echo "$CUPS_ADMIN_USERNAME:$CUPS_ADMIN_PASSWORD" | chpasswd
fi

echo "### Start DBUS service ###"
/etc/init.d/dbus start

echo "### Start AVAHI daemon ###"
/etc/init.d/avahi-daemon start

echo "### Start CUPS service ###"
exec cupsd -f
