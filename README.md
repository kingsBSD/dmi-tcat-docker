
This Docker image allows the deployment of [dmi-tcat](https://github.com/digitalmethodsinitiative/dmi-tcat) using
[docker-compose](https://docs.docker.com/compose/) to provide a [MariaDB container](https://hub.docker.com/_/mariadb/) with
persistant storage. It cannot be guaranteed to overcome any of the deficiencies of dmi-tcat itself.

Assumimg Ubuntu is being used, follow the [Docker installation instructions](https://docs.docker.com/engine/installation/linux/ubuntu/). It
is easiest to install docker-compose via pip, but this is probably safest inside a VirtualEnv, which itself is best installed via pip rather
than your distribution's package-manager:

```
sudo apt-get install python-pip
sudo pip install virtualen
```

Next, download the repo and create a virtualenv for it. Activate it and install docker-compose.

```
git clone https://github.com/kingsBSD/dmi-tcat-docker
virtualenv dmi-tcat-docker
cd dmi-tcat-docker
source ./bin/activate
pip install docker-compose
```

Build and pull the tcat and MariaDB images with `.\build.sh`. Before you can run the containers,
edit [run.sh](https://github.com/kingsBSD/dmi-tcat-docker/blob/master/run.sh). You will need to create a new
[Twitter app](https://apps.twitter.com/). Unlike [Martin Lehmann's](https://github.com/theneva)
[image](https://github.com/theneva/dmi-tcat-docker) on which this one is gratefully based, the passwords
for the "tcat" and "admin" accounts are not hard-coded, they should be set using the `TCAT_PW`and `ADMIN_PW`
environment variables. The database password can (in theory) be left alone, as only the tcat container should
be allowed to connect to the database container. [config.php](https://github.com/kingsBSD/dmi-tcat-docker/blob/master/config.php)
has been modified so that the capture roles (one of `track`, `follow`, or `onepercent`) are set using the
environment variable `CAPTURE_ROLE` set in [docker-compose.yml](https://github.com/kingsBSD/dmi-tcat-docker/blob/master/docker-compose.yml).
The default value is `track`.

Start the containers with `./run.sh`. After a short while, the database will be created and the app will appear on port 8000.
For access to both the "capture" and "analysis" URLs, be sure to log in using the "admin" account. For debugging purposes,
you can test the [GeoPHP](https://geophp.net/geos.html) installation at "/geostest.php", phpinfo is available at "/info.php".
Shell into the container with `sudo docker exec -ti tcat /bin/bash`, the tcat logs will be in `/var/www/html/dmi-tcat/logs`,
it might be worth looking at the Apache logs at `\var\log\apache2`. Stop and delete the containers with `docker-compose stop ` and
`docker-compose rm -f `. Persistant data will be held in `./database`. Leave the virtualenv with `deactivate`.











