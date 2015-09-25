#!/bin/bash


if [ ${DICTYCHADO_ENV_CHADO_USER+defined} -a ${DICTYCHADO_ENV_CHADO_PASS+defined} -a ${DICTYCHADO_ENV_CHADO_DB+defined} ]
then
    dsn="dbi:Pg:host=dictychado;database=${DICTYCHADO_ENV_CHADO_DB}"
## 1. Load organisms
    modware-import organism2chado --log_level debug --dsn $dsn -u $DICTYCHADO_ENV_CHADO_USER -p $DICTYCHADO_ENV_CHADO_PASS
## 2. Load obo
fi
