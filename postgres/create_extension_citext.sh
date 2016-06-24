#!/bin/bash
set -x

create_extension_citext() {
        psql --username postgres <<-EOSQL
            CREATE EXTENSION citext;
EOSQL
}

main() {
    create_extension_citext
}

main
