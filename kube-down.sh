#!/bin/bash
echo "Stopping replication controllers, services and pods..."
kubectl stop replicationcontrollers,services,pods --all
if [ $? != 0 ]; then
    echo "Kubernetes already down?"
fi

if [ ! -z "$(docker-compose -f k8s-local.yml ps -q)" ]; then
    docker-compose -f k8s-local.yml stop
    docker-compose -f k8s-local.yml rm -f -v
fi

k8s_containers=`docker ps -a -f "name=k8s_" -q`

if [ ! -z "$k8s_containers" ]; then
    echo "Stopping and removing all other containers that were started by Kubernetes..."
    docker stop $k8s_containers
    docker rm -f -v $k8s_containers
fi
