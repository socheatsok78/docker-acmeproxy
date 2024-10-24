#!/bin/bash
set -e
chown -R acmeproxy:acmeproxy \
    /home/acmeproxy/.acme.sh \
    /data
