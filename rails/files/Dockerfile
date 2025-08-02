ARG RUBY_VERSION=unset

FROM ruby:${RUBY_VERSION}

ARG POSTGRES_VERSION=unset
ARG NODE_VERSION=unset

RUN useradd -m -u 1000 -s /bin/bash dev

# build tools
RUN apt-get update && \
    apt-get install --no-install-recommends -y \
      build-essential \
      curl \
      git \
      gnupg \
      inotify-tools \
      lsb-release \
      unzip && \
    rm -rf /var/lib/apt/lists/*

# repos
RUN mkdir -p /usr/local/keyrings

# postgres repo
RUN echo -n "deb [signed-by=/usr/local/keyrings/pgdg.gpg]" \
      "http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" \
      > /etc/apt/sources.list.d/pgdg.list && \
    curl -so - https://www.postgresql.org/media/keys/ACCC4CF8.asc | gpg --dearmor \
    > /usr/local/keyrings/pgdg.gpg

# node repo
RUN NODE_MAJOR_VERSION=$(echo ${NODE_VERSION} | cut -d. -f1) \
    curl -fsSL https://deb.nodesource.com/setup_${NODE_MAJOR_VERSION}.x | bash -

# install postgres client and node
RUN POSTGRES_MAJOR_VERSION=$(echo ${POSTGRES_VERSION} | cut -d. -f1) \
    apt-get update && \
    apt-get install --no-install-recommends -y \
      nodejs \
      postgresql-client-${POSTGRES_MAJOR_VERSION} && \
    rm -rf /var/lib/apt/lists/*

# install rails
RUN gem update --system

USER dev
