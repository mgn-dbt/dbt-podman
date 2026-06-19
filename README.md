# Containerized dbt

## Git

Cf [Git submodules](./git.md)

git clone --recurse-submodules https://github.com/mgn-dbt/dbt-podman.git

## Environment

I use SCOOP under Windows and Powershell Core with no admin rights.  

Excerpt from "scoop list" :

```txt
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

Content of `%UserProfile%\.wslconfig`

```ini
[wsl2]
guiApplications=false
vmIdleTimeout=0
networkingMode=mirrored
```

The podman machine (container engine) has been called podman1 instead of the default podman-machine-default.  
Here is the command to create it.  
But you can also use podman-desktop to create it.  

```powershell
podman machine init  podman1
```

If you have Zscaler, for pulling images you need to integrate Zscaler root certificate.  

```powershell
podman machine start podman1
podman machine ssh podman1

Connecting to vm podman1. To close connection, use `~.` or `exit`
[user@HOST ~]$ sudo su -
[root@HOST ~]# cp /mnt/c/Users/<username>/Desktop/zscaler-root-ca.crt /etc/pki/ca-trust/source/anchors/
[root@HOST ~]# update-ca-trust
[root@HOST ~]# exit
```

## Just command runner

Just command runner has been used to simplify commands.  

```powershell
just -l
```

## Base image

**The base image must be built first**  
dbt/Dockerfile is for building the base image.  
It include Zscaler certficate to pass the enterprise security.  
It includes netcat and nano (for editing files and testing network).  
It includes git and dbt-core.  

```powershell
just build_base
```

## Dbt - Duckdb

Duckdb container is based on base image dbt:1.0.1  
dbt/Dockerfile.duckdb only add dbt-duckdb  

docker-compose.duckdb.yml creates only one container  

Create and start container  

```powershell
just duck_up
```

Stop and drop container  

```powershell
just duck_down
```

## Dbt - PostgreSQL

Postgres container is based on base image dbt:1.0.1  
dbt/Dockerfile.pg only add dbt-postgres  

docker-compose.pg.yml creates 2 containers  

Create and start containers  

```powershell
just pg_up
```

Stop and drop containers  

```powershell
just pg_down
```

### Recreate postgres database

The database init process is launched only if pgdata directory is empty.

Stop postgres container and run a alpine container to empty pgdata directory.

```powershell
just pg_reinit
```

### Querying database

Container postgres must be running

```powershell
just pg_ssh
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

The database can be queried with a postgres client on the host (like pgadmin) using localhost:54320 while postgres container is running.  
