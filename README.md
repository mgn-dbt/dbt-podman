# Containerized dbt

## Environment

I use SCOOP under Windows and Powershell Core with no admin rights.  

Excerpt from "scoop list" :

```cmd
pwsh             7.6.2        main
vscode           1.124.0      extras
podman           5.8.2        main
podman-desktop   1.27.2       extras
docker-compose   5.1.4        main
just             1.52.0       main
```

WSL must be installed (admin rights necessary).  
Podman has been chosen as the container software.  
Podman-desktop has been used to manage images, volumes, networks and containers.  
Docker-compose has been installed to manage compose files.

Content of %UserProfile%\\.wslconfig  

```ini
[wsl2]
guiApplications=false
vmIdleTimeout=0
networkingMode=mirrored
```

The podman machine (container engine) has been called podman1 instead of the default podman-machine-default.  
Here is the command to create it.  
But you can also use podman-desktop to create it.  

```cmd
podman machine init  podman1
```

If you have Zscaler, for pulling images you need to integrate Zscaler root certificate.  

```cmd
podman machine start podman1
podman machine ssh podman1

Connecting to vm podman1. To close connection, use `~.` or `exit`
[user@HOST ~]$ sudo su -
[root@HOST ~]# cp /mnt/c/Users/<username>/Desktop/zscaler-root-ca.crt /etc/pki/ca-trust/source/anchors/
[root@HOST ~]# update-ca-trust
[root@HOST ~]# exit
```

## Git submodules

Tuto-init is included in dbt-podman as a git submodule.

Add a git submodule

```cmd
git submodule add https://github.com/mgn-dbt/tuto-init.git dbt/dbt_project
```

Cloning a repository with submodules

```cmd
git clone --recurse-submodules https://github.com/mgn-dbt/dbt-podman.git
```

Update submodules in a repository

```cmd
git submodule update --remote
```

Cf [git submodules](https://blog.stephane-robert.info/docs/developper/version/git/submodules/)

## Just command runner

Just command runner has been used to simplify commands.  

```cmd
# create and start pg
just pg_up
# stop and drop pg
just pg_down
# stop pg
just pg_stop
# start pg
just pg_start
# restart pg
just pg_restart

# create and start duckdb
just duck_up
# stop and drop duckdb
just duck_down
# stop duckdb
just duck_stop
# start duckdb
just duck_start
# restart duckdb
just duck_restart
```

## Base image

dbt/Dockerfile is for building the base image.  
It include Zscaler certficate to pass the enterprise security.  
It includes netcat and nano (for editing files and testing network).  
It includes git and dbt-core.  

```cmd
podman build --tag dbt:1.0.1 -f ./dbt/Dockerfile
```

## Dbt - PostgreSQL

Postgres container is based on base image dbt:1.0.1  
dbt/Dockerfile.pg only add dbt-postgres  

docker-compose.pg.yml creates 2 containers  

Create and start containers  

```cmd
just pg_up
```

Stop and drop containers

```cmd
just pg_down
```

### Querying database

Container postgres must be running

```cmd
podman exec -it postgres bash
psql -d jaffle_shop -U jaffle
```

```sql
-- get schemas
\dn
-- get search_path
SHOW search_path;
-- set search_path
SET search_path TO dbt_user_seeds_ext, "$user", public;
-- list tables
\d+
-- desc customers
\d+ customers
-- access privs on customers
\dp customers
```

The database can be queried with a postgres client on the host (like pgadmin) using localhost:54320.  
Again container postgres must be running.

### Recreate postgres database

The database init process is launched only if pgdata directory is empty.

Stop postgres container and run a alpine container to empty pgdata directory.

```cmd
just pg_stop

podman run --rm -v dbtlab_pg_pgdata:/data:rw docker.io/library/alpine rm -rf /data/18

just pg_up
```

## Dbt - Duckdb

Duckdb container is based on base image dbt:1.0.1  
dbt/Dockerfile.duckdb only add dbt-duckdb  

docker-compose.duckdb.yml creates only one container  

Create and start container  

```cmd
just duck_up
```

Stop and drop containers

```cmd
just duck_down
```
