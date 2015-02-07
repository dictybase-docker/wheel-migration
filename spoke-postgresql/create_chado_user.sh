#!/bin/bash


if [ "${CHADO_USER+defined}" -a "${CHADO_PASS+defined}" -a "${CHADO_DB+defined}" ]
then
        gosu postgres postgres --single -E <<-EOSQL
            CREATE ROLE $CHADO_USER WITH CREATEDB LOGIN ENCRYPTED PASSWORD '$CHADO_PASS';
            CREATE DATABASE $CHADO_DB OWNER $CHADO_USER;
EOSQL
fi
