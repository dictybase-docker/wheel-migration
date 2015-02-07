#!/bin/bash

cd /data
curl -L -o sqitch-dictychado-1.23.tar.bz2 https://github.com/dictyBase/Chado-Sqitch/releases/download/dictychado-1.23/sqitch-dictychado-1.23.tar.gz
tar xvjf sqitch-dictychado-1.23.tar.bz2 
cd sqitch-dictychado-1.23
cp sqitch.conf /config/sqitch.conf
sqitch config --user core.engine.pg.client `which psql`

if [ ${SQITCH_USER+defined} -a ${SQITCH_PASS+defined} -a ${SQITCH_DB+defined} ]
then
    sqitch target add dictychado db:pg://${SQITCH_USER}:${SQITCH_PASS}@dictychado/${SQITCH_DB}
    sqitch deploy -t dictychado
elif [ ${DICTYCHADO_ENV_CHADO_USER+defined} -a ${DICTYCHADO_ENV_CHADO_PASS+defined} -a ${DICTYCHADO_ENV_CHADO_DB+defined} ]
then
    sqitch target add dictychado db:pg://${DICTYCHADO_ENV_CHADO_USER}:${DICTYCHADO_ENV_CHADO_PASS}@dictychado/${DICTYCHADO_ENV_CHADO_DB}
    sqitch deploy -t dictychado
else
    echo does not have any information about the database to deploy
fi




