#!/bin/sh

kubectl create -f volume.json
kubectl create -f claim.json
kubectl create -f service.json
kubectl create -f pod.json
