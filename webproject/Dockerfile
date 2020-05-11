FROM python:3.7.7-slim

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Create a group and user to run our app
ARG APP_USER=website
RUN useradd ${APP_USER}

# Install packages needed to run your application (not build deps):
# We need to recreate the /usr/share/man/man{1..8} directories first because
# they were clobbered by a parent image.
RUN set -ex \
    && RUN_DEPS=" \
        postgresql-client \
        dos2unix \
    " \
    && seq 1 8 | xargs -I{} mkdir -p /usr/share/man/man{} \
    && apt-get update \
    && apt-get install -y --no-install-recommends $RUN_DEPS \
    && rm -rf /var/lib/apt/lists/*

# Set work directory
WORKDIR /home/${APP_USER}/src/

# Copy in your requirements file
COPY requirements.txt .

# Install build deps, then run `pip install`, then remove unneeded build deps all in a single step.
# Correct the path to your production requirements file, if needed.
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

# Copy your application code to the container
COPY --chown=${APP_USER} . .
RUN dos2unix docker-entrypoint.sh
RUN chmod a+x docker-entrypoint.sh

# Change to a non-root user
USER ${APP_USER}

ENTRYPOINT ["./docker-entrypoint.sh"]

CMD gunicorn ecommerce.wsgi:application --bind 0.0.0.0:8000
