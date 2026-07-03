# https://docs.docker.com/reference/dockerfile

# https://www.debian.org/releases/  Stretch/Buster/Bullseye/Bookworm/Trixie // Forky/Duke
FROM python:3.12.7-slim-bookworm

# https://docs.docker.com/guides/zscaler/
COPY zscaler-root-ca.crt /usr/local/share/ca-certificates/zscaler-root-ca.crt
RUN update-ca-certificates

# add git, nano and netcat
RUN apt-get update \
    && apt-get install -y --no-install-recommends netcat-traditional nano git \
    && rm -rf /var/lib/apt/lists/*

# https://docs.docker.com/build/cache/optimize/#use-cache-mounts
# Upgrade pip and install dbt-core
RUN pip install --upgrade pip
RUN pip install --no-cache-dir dbt-core==1.11.9 pip_system_certs
# RUN rm -rf /root/.cache

CMD ["bash", "-c", "tail -f /dev/null"]

# podman build --tag dbt:1.0.2 -f ./dbt/docker/Dockerfile

