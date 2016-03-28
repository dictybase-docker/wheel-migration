CURRDIR = $(shell pwd)
FOLDER = $(shell dirname $(abspath $(lastword $(MAKEFILE_LIST))))
PG_LOCAL_FOLDER = $(FOLDER)/postgres/kubernetes/local
SQITCH_FOLDER = $(FOLDER)/sqitch/kubernetes/local
DB_MANAGER_FOLDER = $(FOLDER)/data-manager/kubernetes/local
DB_IMPORT_FOLDER = $(FOLDER)/data-import/kubernetes/local
start-pg:
	kubectl create -f $(PG_LOCAL_FOLDER)/volume.json
	kubectl create -f $(PG_LOCAL_FOLDER)/claim.json
	kubectl create -f $(PG_LOCAL_FOLDER)/service.json
	kubectl create -f $(PG_LOCAL_FOLDER)/rc.json
	kubectl create -f $(PG_LOCAL_FOLDER)/secrets.json
stop-pg:
	kubectl delete -f $(PG_LOCAL_FOLDER)/rc.json
	kubectl delete -f $(PG_LOCAL_FOLDER)/service.json
purge-pg: stop-pg
	kubectl delete -f $(PG_LOCAL_FOLDER)/claim.json
	kubectl delete -f $(PG_LOCAL_FOLDER)/volume.json
	kubectl delete -f $(PG_LOCAL_FOLDER)/secrets.json
start-sqitch:
	kubectl create -f $(SQITCH_FOLDER)/pod.json
stop-sqitch:
	kubectl delete -f $(SQITCH_FOLDER)/pod.json
start-dm:
	kubectl create -f $(DB_MANAGER_FOLDER)/pod.json
stop-dm:
	kubectl delete -f $(DB_MANAGER_FOLDER)/pod.json
start-data-import:
	kubectl create -f $(DB_IMPORT_FOLDER)/core_pod.json
stop-data-import: 
	kubectl delete -f $(DB_IMPORT_FOLDER)/core_pod.json
data-import: start-pg start-sqitch start-dm start-data-import
purge-import: stop-data-import stop-dm stop-sqitch purge-pg
	kubectl create -f $(FOLDER)/etcd-cleanup/pod.json
	sleep 5
	kubectl delete -f $(FOLDER)/etcd-cleanup/pod.json
start-db-backup:
	kubectl create -f $(PG_LOCAL_FOLDER)/dump.json
purge-db-backup:
	kubectl delete -f $(PG_LOCAL_FOLDER)/dump.json
start-db-restore:
	sleep 3
	kubectl create -f $(PG_LOCAL_FOLDER)/restore.json
purge-db-restore:
	kubectl delete -f $(PG_LOCAL_FOLDER)/restore.json
start-pgweb:
	kubectl create -f $(PG_LOCAL_FOLDER)/pgwebsvc.json
	kubectl create -f $(PG_LOCAL_FOLDER)/pgwebrc.json
purge-pgweb:
	kubectl delete -f $(PG_LOCAL_FOLDER)/pgwebrc.json
	kubectl delete -f $(PG_LOCAL_FOLDER)/pgwebsvc.json


