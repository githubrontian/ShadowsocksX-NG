#!/bin/bash

# A shadowsocks SIP003 adapter shell script.
#
# SIP003 Docucment: https://github.com/shadowsocks/shadowsocks-org/issues/28
#
# Created by Qiu Yuzhou on 2019-09-09
# Copyright © 2019 Qiu Yuzhou. All rights reserved.

# test data, Start
# SS_REMOTE_HOST=127.0.0.1
# SS_REMOTE_PORT=8088
# SS_LOCAL_HOST=192.168.1.1
# SS_LOCAL_PORT=888
# test data, End

SS_ENV_NAMES=(SS_REMOTE_HOST SS_REMOTE_PORT SS_LOCAL_HOST SS_LOCAL_PORT)

for i in "${SS_ENV_NAMES[@]}"; do
    if [ -z ${!i} ]
    then
        echo Not found env variable $i
        exit
    fi
done

# Split options
IFS=';' read -ra _OPTS <<< "${SS_PLUGIN_OPTIONS}"

# Prepend `--`
OPTS=()
for i in "${_OPTS[@]}"; do
    OPTS+=("--$i")
done

PLUGIN_NAME="kcptun"
PLUGIN_VERSION="v20190905"
PLUGIN_BINARY_NAME="client"

CMD="$(dirname "${BASH_SOURCE[0]}")/../${PLUGIN_NAME}_${PLUGIN_VERSION}/${PLUGIN_BINARY_NAME}"

# Update this line when adapted other plugin.
"$CMD" -r "${SS_REMOTE_HOST}:${SS_REMOTE_PORT}" -l "${SS_LOCAL_HOST}:${SS_LOCAL_PORT}" ${OPTS[@]}
