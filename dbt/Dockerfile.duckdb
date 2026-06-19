# https://docs.docker.com/reference/dockerfile

FROM dbt:1.0.1

RUN pip install dbt-duckdb==1.10.1

# cf docker-compose volumes
WORKDIR /usr/src/dbt

# https://docs.getdbt.com/docs/local/profiles.yml?version=1.11&name=Core
ENV DBT_ENV_NAME=dev
ENV DBT_ENGINE_PROFILES_DIR=/usr/src/dbt
ENV DBT_ENGINE_PROFILE=duckdb

LABEL description="Image dbt-core 1.11 with dbt-duckdb 1.10.1"

# Default command to run if no other command is specified
CMD ["bash", "-c", "tail -f /dev/null"]

