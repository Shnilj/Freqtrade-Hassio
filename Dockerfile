ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8

COPY config-off.json /freqtrade/config.json
COPY strategies/* /freqtrade/user_data/strategies/

# Install Python
# Environment variables
ENV \
    PATH="/usr/local/bin:$PATH" \
    GPG_KEY="E3FF2839C048B25C084DEBE9B26995E310250568" \
    PYTHON_VERSION="3.8.7" \
    PYTHON_PIP_VERSION="21.0.1"

# Set shell
# SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Base system
RUN \
    set -x \
    && apt-get install -y \
        bash \
        jq \
        tzdata \
        curl \
        ca-certificates \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /usr/share/man/man1 \
    \
    && curl -L -f -s "https://github.com/just-containers/s6-overlay/releases/download/v2.2.0.3/s6-overlay-aarch64.tar.gz" \
        | tar zxvf - -C / \
    && mkdir -p /etc/fix-attrs.d \
    && mkdir -p /etc/services.d \
    \
    && curl -L -f -s -o /usr/bin/tempio \
        "https://github.com/home-assistant/tempio/releases/download/2021.01.0/tempio_aarch64" \
    && chmod a+x /usr/bin/tempio \
    \
    && mkdir -p /tmp/bashio \
    && curl -L -f -s "https://github.com/hassio-addons/bashio/archive/refs/tags/v0.13.0.tar.gz" \
        | tar -xzf - --strip 1 -C /tmp/bashio \
    && mv /tmp/bashio/lib /usr/lib/bashio \
    && rm -rf /tmp/bashio

# Install jq
# RUN apt-get install jq

# Copy data for add-on
# COPY run.sh /
# RUN chmod a+x /run.sh

CMD [ "trade" ]