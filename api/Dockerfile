FROM python:3.7.7-slim

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Install packages needed to run your application (not build deps):
# We need to recreate the /usr/share/man/man{1..8} directories first because
# they were clobbered by a parent image.
RUN set -ex \
    && RUN_DEPS=" \
        postgresql-client \
        ssh-client \
        git \
    " \
    && seq 1 8 | xargs -I{} mkdir -p /usr/share/man/man{} \
    && apt-get update \
    && apt-get install -y --no-install-recommends $RUN_DEPS \
    && rm -rf /var/lib/apt/lists/*

# Install build deps, then run `pip install`, then remove unneeded build deps all in a single step.
COPY api/requirements.txt requirements.txt

RUN set -ex \
    && BUILD_DEPS=" \
        gcc \
        libpcre3-dev \
        libpq-dev \
    " \
    && apt-get update \
    && apt-get install -y --no-install-recommends $BUILD_DEPS \
    && pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false $BUILD_DEPS \
    && rm -rf /var/lib/apt/lists/*

# Change to a non-root user
ARG APP_USER
RUN useradd -ms /bin/bash ${APP_USER}
USER ${APP_USER}

# Copy your application code to the container
WORKDIR /home/${APP_USER}/src
COPY --chown=${APP_USER} . .
WORKDIR /home/${APP_USER}/src/api
RUN chmod u+x docker-entrypoint.sh

ENTRYPOINT ["./docker-entrypoint.sh"]
