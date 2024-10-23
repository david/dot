FROM ghcr.io/ublue-os/ubuntu-toolbox:latest

LABEL com.github.containers.toolbox="true" \
      usage="This image is meant to be used with the toolbox or distrobox command" \
      summary="A cloud-native terminal experience" \
      maintainer="david@davidleal.com"

ENV DEBIAN_FRONTEND noninteractive
ENV USER_ID=1000

RUN apt-get update --assume-yes && \
    apt-get upgrade --assume-yes && \
    apt-get install --assume-yes --no-install-recommends \
      adwaita-icon-theme-full \
      build-essential \
      curl \
      file \
      git \
      locales \
      procps \
      wl-clipboard && \
    apt-get clean && \
    rm -fr /var/lib/apt/lists/* && \
    localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 && \
    useradd -u "${USER_ID}" --create-home --shell /bin/bash --user-group linuxbrew && \
    echo 'linuxbrew ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

ENV LANG en_US.utf8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.utf8

USER linuxbrew
WORKDIR /home/linuxbrew
ENV NONINTERACTIVE=1

RUN curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash
RUN .linuxbrew/bin/brew install gcc@11 git ruby

USER root

RUN userdel linuxbrew
