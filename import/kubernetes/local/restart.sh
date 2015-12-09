#!/bin/sh

kubectl create -f pgvolume.json
kubectl create -f pgclaim.json
kubectl create -f pgservice.json
kubectl create -f pgrc.json

