#!/usr/bin/env bash
# vim:sw=4:ts=4:et
set -e

entrypoint_log() {
    if [ -z "${ACMEPROXY_ENTRYPOINT_QUIET_LOGS:-}" ]; then
        echo "$@"
    fi
}

# usage: file_env VAR [DEFAULT]
#    ie: file_env 'XYZ_DB_PASSWORD' 'example'
# (will allow for "$XYZ_DB_PASSWORD_FILE" to fill in the value of
#  "$XYZ_DB_PASSWORD" from a file, especially for Docker's secrets feature)
file_env() {
	local var="$1"
	local fileVar="${var}_FILE"
	local def="${2:-}"
	if [ "${!var:-}" ] && [ "${!fileVar:-}" ]; then
		mysql_error "Both $var and $fileVar are set (but are exclusive)"
	fi
	local val="$def"
	if [ "${!var:-}" ]; then
		val="${!var}"
	elif [ "${!fileVar:-}" ]; then
		val="$(< "${!fileVar}")"
	fi
	export "$var"="$val"
	unset "$fileVar"
}

# Convert all environment variables with names ending in __FILE into the content of
# the file that they point at and use the name without the trailing __FILE.
# This can be used to carry in Docker secrets.
for VAR_NAME in $(env | grep '^[^=]\+__FILE=.\+' | sed -r "s/([^=]*)__FILE=.*/\1/g"); do
    VAR_NAME_FILE="$VAR_NAME"__FILE
    if [ "${!VAR_NAME}" ]; then
        echo >&2 "ERROR: Both $VAR_NAME and $VAR_NAME_FILE are set (but are exclusive)"
        exit 1
    fi
    echo "Getting secret $VAR_NAME from ${!VAR_NAME_FILE}"
    export "$VAR_NAME"="$(< "${!VAR_NAME_FILE}")"
    unset "$VAR_NAME_FILE"
done

if /usr/bin/find "/docker-entrypoint.d/" -mindepth 1 -maxdepth 1 -type f -print -quit 2>/dev/null | read v; then
    entrypoint_log "$0: /docker-entrypoint.d/ is not empty, will attempt to perform configuration"

    entrypoint_log "$0: Looking for shell scripts in /docker-entrypoint.d/"
    find "/docker-entrypoint.d/" -follow -type f -print | sort -V | while read -r f; do
        case "$f" in
            *.envsh)
                if [ -x "$f" ]; then
                    entrypoint_log "$0: Sourcing $f";
                    source "$f"
                else
                    # warn on shell scripts without exec bit
                    entrypoint_log "$0: Ignoring $f, not executable";
                fi
                ;;
            *.sh)
                if [ -x "$f" ]; then
                    entrypoint_log "$0: Launching $f";
                    "$f"
                else
                    # warn on shell scripts without exec bit
                    entrypoint_log "$0: Ignoring $f, not executable";
                fi
                ;;
            *) entrypoint_log "$0: Ignoring $f";;
        esac
    done

    entrypoint_log "$0: Configuration complete; ready for start up"
else
    entrypoint_log "$0: No files found in /docker-entrypoint.d/, skipping configuration"
fi

exec s6-setuidgid acmeproxy perl /acmeproxy.pl
