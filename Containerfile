FROM quay.io/toolbx-images/ubuntu-toolbox:latest

LABEL com.github.containers.toolbox="true" \
      usage="This image is meant to be used with the toolbox or distrobox command" \
      summary="A cloud-native terminal experience" \
      maintainer="david@davidleal.com"

RUN apt-get update --assume-yes && \
    apt-get dist-upgrade --assume-yes && \
    apt-get install --assume-yes --no-install-recommends \
      build-essential \
      curl \
      file \
      git \
      procps \
      wl-clipboard

ENV USER_ID=1000

RUN userdel -r ubuntu && \
    useradd -u "${USER_ID}" --create-home --shell /bin/bash --user-group linuxbrew && \
    echo 'linuxbrew ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
    su - linuxbrew -c 'mkdir ~/.linuxbrew'

USER linuxbrew

ENV NONINTERACTIVE=1
RUN curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash
RUN eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" && \
    brew install git ruby && \
    sudo apt-get remove --purge --assume-yes git && \
    sudo apt-get autoremove --purge --assume-yes

USER root

RUN userdel linuxbrew
