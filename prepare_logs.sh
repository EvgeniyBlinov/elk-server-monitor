#!/bin/bash
SCRIPT_PATH=`dirname $0`
ABSOLUTE_PATH=`readlink -m ${SCRIPT_PATH}`

LOG_PATH=`readlink -m ${ABSOLUTE_PATH}/logs/tmp`

function gunzip_logs {
    local path="$1"
    #local overwrite="$2"
    ls -1 "$path" |
        while read log_name; do
            local log_file="$(readlink -m "$1")/$log_name"
            if echo "$log_name"|grep -qP '\.gz?$'; then
                gunzip -f "${log_file}"
            fi
        done
}

function fetch {
    cat "$1"|
        while read line; do
            local target="$(echo $line|sed 's/\t\$//')"
            local src="${target%=*}"
            local dest="${target#*=}"
            rsync -zvh \
                "$src" \
                "$dest"
            gunzip_logs "$dest"
        done
}

fetch ${ABSOLUTE_PATH}/.logs
