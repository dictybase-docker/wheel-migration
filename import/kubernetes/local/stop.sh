#!/bin/sh

kubectl delete po chado-sqitch
kubectl delete rc postgres-db
kubectl delete svc postgres
kubectl delete pvc postgres-claim1
kubectl delete pv pv-local1
