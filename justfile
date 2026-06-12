
# use PowerShell instead of sh:
set shell := ["pwsh.exe", "-c"]

# Set shell for Windows OSs:
set windows-shell := ["pwsh.exe", "-NoLogo", "-Command"]

BASE := "docker-compose"

hello:
    @Write-Host "Hello, world!"

# machine
start:
    podman machine start podman1

stop:
    podman machine stop podman1

# pg
pg_conf:
    podman compose -f {{BASE}}.pg.yml config

pg_ps:
    podman compose -f {{BASE}}.pg.yml ps

pg_up:
    podman compose -f {{BASE}}.pg.yml up --detach

pg_down:
    podman compose -f {{BASE}}.pg.yml down

pg_stop:
    podman compose -f {{BASE}}.pg.yml stop

pg_restart:
    podman compose -f {{BASE}}.pg.yml restart

pg_start:
    podman compose -f {{BASE}}.pg.yml start

pg_ssh:
    podman exec -it postgres bash

# duckdb
duck_conf:
    podman compose -f {{BASE}}.duckdb.yml config

duck_ps:
    podman compose -f {{BASE}}.duckdb.yml ps

duck_up:
    podman compose -f {{BASE}}.duckdb.yml up --detach

duck_down:
    podman compose -f {{BASE}}.duckdb.yml down

duck_stop:
    podman compose -f {{BASE}}.duckdb.yml stop

duck_restart:
    podman compose -f {{BASE}}.duckdb.yml restart

duck_start:
    podman compose -f {{BASE}}.duckdb.yml start