# Data migration for dictyBase
This is a source repository for [docker](http://docker.io) image to run
[dictyBase](http://dictybase.org) data migration tasks. The docker container setup is based on [radial](https://github.com/radial/docs)
topology. 

## Usage
The migration task is run using [kubernetes](http://kubernetes.io). Kubernetes can be run both locally(dev version)
and in [google compute engine](https://cloud.google.com/compute/). 
For both the cases,
[kubectl](http://kubernetes.io/v1.0/docs/user-guide/kubectl/kubectl.html)
command line client need to be installed.

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

The above with create a 25G of persistent volume and a 20G of persistent claim. To change
any of the default parameter change the configurations accordingly.

* Run the postgresql service and pod with replication controller. By default,
  the database will be initialized with 20G of disk space(from 20G persistent
  claim).

```
$_> kubectl create -f service.json; kubectl create -f pod.json
```

### Google compute engine
* [Download](https://github.com/kubernetes/kubernetes/releases) latest kubernetes and untar it.
* [Setup](http://kubernetes.io/v1.0/docs/getting-started-guides/gce.html) all
  prerequisites for google compute engine to run the cluster.
* Go to untar kubernetes folder and start the cluster.

```
$_> cd kubernetes
$_> cluster/kube-up.sh
```

* Create a GCE disk named 'database-disk'.
```
$_> gcloud compute disks create --size 30GB database-disk.
```

The disk size cannot be below 25GB.

* Create volume and claim.

```
$_> kubectl create -f volume.json; kubectl create -f claim.json
```

* To create secrets, copy the `example_secrets.json` to `secrets.json` (any
  other name will also work) and fill up all the seven fields. All fields need to be
  base64 encoded.

```
$_> kubectl create -f secrets.json
```

* Now start the postgresql database server service and pod.

```
$_> kubectl create -f service.json; kubectl create -f pod-pvc-secret.json
```
