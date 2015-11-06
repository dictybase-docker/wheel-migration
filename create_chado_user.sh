#!/bin/bash

register_etcd() {
    if [ ${ETCD_CLIENT_SERVICE_HOST+defined} ]
    then
        curl http://${ETCD_CLIENT_SERVICE_HOST}:${ETCD_CLIENT_SERVICE_PORT}/v2/keys/migration/postgresql -XPUT -d value="complete"
    else
        echo "did not register with etcd"
    fi
}

extract_secret(){
    [ -e "/secrets/chadouser" ] && CHADO_USER=cat $(cat /etc/chadouser)
    [ -e "/secrets/chadodb" ] && CHADO_DB=cat $(cat /etc/chadodb)
    [ -e "/secrets/chadouser" ] && CHADO_USER=cat $(cat /etc/chadopass)
}

create_chado_user() {
    if [ "${CHADO_USER+defined}" -a "${CHADO_PASS+defined}" -a "${CHADO_DB+defined}" ]
    then
            psql --username postgres <<-EOSQL
                CREATE ROLE $CHADO_USER WITH CREATEDB LOGIN ENCRYPTED PASSWORD '$CHADO_PASS';
                CREATE DATABASE $CHADO_DB OWNER $CHADO_USER;
EOSQL
    fi
}

main() {
    extract_secret
    create_chado_user
    register_etcd
}

main



