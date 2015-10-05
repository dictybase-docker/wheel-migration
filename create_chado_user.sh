#!/bin/bash

if [ -e "/secrets/chadouser" ]
then
    CHADO_USER=cat $(cat /etc/chadouser)
fi

if [ -e "/secrets/chadodb" ]
then
    CHADO_USER=cat $(cat /etc/chadodb)
fi

if [ -e "/secrets/chadouser" ]
then
    CHADO_USER=cat $(cat /etc/chadouser)
fi


if [ "${CHADO_USER+defined}" -a "${CHADO_PASS+defined}" -a "${CHADO_DB+defined}" ]
then
        psql --username postgres <<-EOSQL
            CREATE ROLE $CHADO_USER WITH CREATEDB LOGIN ENCRYPTED PASSWORD '$CHADO_PASS';
            CREATE DATABASE $CHADO_DB OWNER $CHADO_USER;
EOSQL
fi
