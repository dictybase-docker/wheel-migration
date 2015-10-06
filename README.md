# Data migration for dictyBase
This is a source repository for [docker](http://docker.io) image to run
[dictyBase](http://dictybase.org) data migration tasks. The docker container setup is based on [radial](https://github.com/radial/docs)
topology. 

## Usage
The migration task is run using [kubernetes](http://kubernetes.io). Kubernetes can be run both locally(dev version)
and in [google compute engine](https://cloud.google.com/compute/). 

### Local

* Install [docker compose](https://docs.docker.com/compose/).
* Clone this repository and start up a single node kubernetes cluster.

```
$_> docker-compose -f k8s-local.yml
```
* Go the kubernetes folder. 

```
$_> cd spoke-postgresql/kubernetes/k8s-local
```
* Create a persistent volume and a volume claim. For this to work
  `/mnt/docker/database` folder need to exist, if not alter the configuration
  accordingly in the `volume.json` file.

```
$_> kubectl create -f volume.json; kubectl create -f claim.json
```

The above with create a 25G of persistent volume and a claim of 20G. To change
any of the default parameter change the configuration accordingly.

