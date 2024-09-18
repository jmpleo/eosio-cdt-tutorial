#!/bin/bash

keosd > /dev/null 2>&1 &
nodeos -e -p eosio \
    --plugin eosio::producer_plugin \
    --plugin eosio::producer_api_plugin \
    --plugin eosio::chain_api_plugin \
    --plugin eosio::http_plugin \
    --plugin eosio::history_plugin \
    --plugin eosio::history_api_plugin \
    --filter-on="*" \
    --access-control-allow-origin='*' \
    --contracts-console \
    --http-validate-host=false \
    --verbose-http-errors >> nodeos.log 2>&1 &

# create account for developer associated with pubkey of wallet default
cleos create account eosio dev $(cat /tmp/cleos_default_pub_key)

tail -f nodeos.log


