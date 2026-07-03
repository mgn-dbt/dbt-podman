# use PowerShell instead of sh:
set shell := ["pwsh.exe", "-c"]
# Set shell for Windows OSs:
set windows-shell := ["pwsh.exe", "-NoLogo", "-Command"]
# formatage
# just --dump > justfile.fmt
# just --fmt --check
BASE := "docker-compose"
[doc('List tasks')]
default:
    just --list --unsorted
#
[doc('Start podman machine')]
start:
    podman machine start podman1
[doc('Stop podman machine')]
stop:
    podman machine stop podman1
[doc('List podman machines')]
machine:
    podman machine list
[doc('Podman stats')]
stats:
    podman stats --no-stream
ps:
    podman compose -f {{ BASE }}.pg.yml ps
    podman compose -f {{ BASE }}.duckdb.yml ps
#
[doc('Build dbt base image')]
build_base:
    podman build --tag dbt:1.0.2 -f ./dbt/docker/Dockerfile
#
[doc('Verify docker-compose.pg.yml')]
pg_conf:
    podman compose -f {{ BASE }}.pg.yml config
[doc('Create and start dbt_pg and postgres containers')]
pg_up:
    podman compose -f {{ BASE }}.pg.yml up --detach
[doc('Stop and drop dbt_pg and postgres containers')]
pg_down:
    podman compose -f {{ BASE }}.pg.yml down
[doc('Drop pg database and recreate it')]
pg_reinit:
    just pg_stop
    podman run --rm -v dbtlab_pg_pgdata:/data:rw docker.io/library/alpine rm -rf /data/*
    just pg_up
[doc('SSH in pg')]
pg_ssh:
    podman exec -it postgres bash
pg_start:
    podman compose -f {{ BASE }}.pg.yml start
pg_stop:
    podman compose -f {{ BASE }}.pg.yml stop
pg_restart:
    podman compose -f {{ BASE }}.pg.yml restart
#
[doc('Verify docker-compose.duckdb.yml')]
duck_conf:
    podman compose -f {{ BASE }}.duckdb.yml config
[doc('Create and start dbt_duckdb container')]
duck_up:
    podman compose -f {{ BASE }}.duckdb.yml up --detach
[doc('Stop and drop dbt_duckdb container')]
duck_down:
    podman compose -f {{ BASE }}.duckdb.yml down
duck_start:
    podman compose -f {{ BASE }}.duckdb.yml start
duck_stop:
    podman compose -f {{ BASE }}.duckdb.yml stop
duck_restart:
    podman compose -f {{ BASE }}.duckdb.yml restart
