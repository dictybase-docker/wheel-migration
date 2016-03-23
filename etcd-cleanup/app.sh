#!/bin/bash

ETCD_PATH=http://${ETCD_CLIENT_SERVICE_HOST}:${ETCD_CLIENT_SERVICE_PORT}/v2/keys
curl ${ETCD_PATH}/migration/download -XDELETE
curl ${ETCD_PATH}/migration/postgresql -XDELETE
curl ${ETCD_PATH}/migration/sqitch -XDELETE
curl ${ETCD_PATH}/migration/organism -XDELETE
curl ${ETCD_PATH}/migration?dir=true -XDELETE

