#!/bin/bash

#This script will allow you run a clore compute instance on your MMP OS rig and have it stop the miner when the system gets rented, and restart the miner when the rental ends. You need a paid accoutn on mmp os to unlock the API function (this is as simple as buying even a single credit)

CLORE_SERVER_NAME="RIG1"
CLORE_API_KEY="xxx"

MMP_FARM_ID="xxx-xxx-xxx-xxx-xxx"
MMP_RIG_ID="xxx-xxx-xxx-xxx-xxx"
MMP_API_KEY="xxx-xxx-xxx-xxx-xxx"

#######################################################

#Get Clore Rented Status
CLORE_RENTAL_STATUS=$(curl -X GET -H "auth: $CLORE_API_KEY" -H "Content-type: application/json" -d "{\"server_name\":\"$CLORE_SERVER_NAME\"}" 'https://api.clore.ai/v1/server_config' | jq .config.rental_status)

#Get MMPOS Mining Status
MMP_MINING_STATUS=$(curl -X GET -H "X-API-Key: ${MMP_API_KEY}" -H "Content-Type: application/json" "https://api.mmpos.eu/api/v1/${MMP_FARM_ID}/rigs/${MMP_RIG_ID}" | jq -r ' .status')

#rented, but mining
if [ "$CLORE_RENTAL_STATUS" != 0 ] && [ $MMP_MINING_STATUS == "ok" ]; then
        echo "stop mining"
        curl -X POST -H "X-API-Key: ${MMP_API_KEY}" -H "Content-Type: application/json" -d '{"control": "disable"}' "https://api.mmpos.eu/api/v1/${MMP_FARM_ID}/rigs/${MMP_RIG_ID}/control"

#not rented and not mining
elif [ "$CLORE_RENTAL_STATUS" == 0 ] && [ $MMP_MINING_STATUS == "miner_disabled" ]; then
   echo "start mining"
        curl -X POST -H "X-API-Key: ${MMP_API_KEY}" -H "Content-Type: application/json" -d '{"control": "enable"}' "https://api.mmpos.eu/api/v1/${MMP_FARM_ID}/rigs/${MMP_RIG_ID}/control"

fi
exit 0
