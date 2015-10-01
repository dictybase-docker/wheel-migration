# Postgresql instance for chado database
This is a source repository for [docker](http://docker.io) image to run
[chado](http://gmod.org/wiki/Chado) database instance in postgresql container.
It is based on the generic postgresql
[image](https://hub.docker.com/r/dictybase/postgres/) image. In addition, this
current image source provides the following features/properties

## Additional features/properties
### Configuration files
Adds bunch of fined grained database configurations that are available as
separate files. The following `conf` files are provided.

```
01resource.conf
02wal.conf
03query.conf
04.log.conf
05vaccum.conf
```

They get sourced in order by the main `postgresql.conf` file. 

### Environmental variables
Provide a set of environmental variables to create a database and a
regular(not superuser) database user during the initialization process. Here
are the variables.

```
CHADO_USER 
CHADO_PASS
CHADO_DB
```

All three variables are required.

## Usage
It's identical to the base image, read the documentation
[here](https://hub.docker.com/r/dictybase/postgres/).

