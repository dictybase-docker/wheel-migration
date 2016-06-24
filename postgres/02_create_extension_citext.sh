#!/bin/bash
set -x

extract_secret() {
   if [ -e "/secrets/chadodb" ] 
   then
       CHADO_DB=$(cat /secrets/chadodb)
   fi
}

create_extension_citext() {
    if [ "${CHADO_DB+defined}" ]
    then
        psql --username postgres --dbname ${CHADO_DB} <<-EOSQL
            CREATE EXTENSION citext;
EOSQL
    fi
}

main() {
    extract_secret
    create_extension_citext
}

main
