# https://docs.docker.com/reference/dockerfile

FROM dbt:1.0.2

RUN pip install dbt-postgres==1.10.0

# cf docker-compose volumes
WORKDIR /usr/src/dbt

# https://docs.getdbt.com/docs/local/profiles.yml?version=1.11&name=Core
ENV DBT_ENV_NAME=dev
ENV DBT_ENGINE_PROFILES_DIR=/usr/src/dbt
ENV DBT_ENGINE_PROFILE=pg

LABEL description="Image dbt-core 1.11 with dbt-postgres 1.10.0"

# Default command to run if no other command is specified
CMD ["bash", "-c", "tail -f /dev/null"]

