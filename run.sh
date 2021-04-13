#!/usr/bin/with-contenv bashio

if ! bashio::fs.directory_exists '/share/freqtrade'; then
    mkdir -p /share/freqtrade \
        || bashio::exit.nok 'Failed to create initial freqtrade media folder'
fi

USERNAME=$(bashio::config 'username')
TIMEFRAME=$(bashio::config 'timeframe')

bashio::log.info "${USERNAME}"

#jq --arg variable "$USERNAME" '.api_server.username = $variable' /freqtrade/config.json > /freqtrade/config.json.tmp && mv /freqtrade/config.json.tmp /freqtrade/config.json
#jq --arg variable "$TIMEFRAME" '.timeframe = "5m"' /share/freqtrade/config.json > /share/freqtrade/config.json.tmp && mv /share/freqtrade/config.json.tmp /share/freqtrade/config.json

bash ./trade.sh