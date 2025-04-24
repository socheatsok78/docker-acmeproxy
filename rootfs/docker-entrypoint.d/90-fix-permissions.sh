#!/bin/bash
set -e
if [ -d "/home/acmeproxy/.acme.sh" ]; then
	chown -R acmeproxy:acmeproxy /home/acmeproxy/.acme.sh
fi

if [ -d "/data" ]; then
	chown -R acmeproxy:acmeproxy /data
fi
