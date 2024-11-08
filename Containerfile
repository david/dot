FROM ghcr.io/ublue-os/ubuntu-toolbox:latest

LABEL com.github.containers.toolbox="true" \
      usage="This image is meant to be used with the toolbox or distrobox command" \
      summary="A cloud-native terminal experience" \
      maintainer="david@davidleal.com"

ENV DEBIAN_FRONTEND noninteractive
ENV LANG en_US.utf8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.utf8
ENV NONINTERACTIVE 1
ENV USER_ID 1000

RUN curl -fsSLo \
      /usr/share/keyrings/brave-browser-archive-keyring.gpg \
      https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg && \
    echo -n "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] " \
      "https://brave-browser-apt-release.s3.brave.com/ stable main" > \
      /etc/apt/sources.list.d/brave-browser-release.list && \
    apt-get update --assume-yes && \
    apt-get upgrade --assume-yes && \
    apt-get install --assume-yes \
      adwaita-icon-theme \
      build-essential \
      brave-browser \
      locales \
      wl-clipboard && \
    apt-get clean && \
    rm -fr /var/lib/apt/lists/* /var/cache/apt/archives/* && \
    localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 && \
    useradd -u "${USER_ID}" --create-home --shell /bin/bash --user-group linuxbrew

USER linuxbrew

RUN curl -fsSLo /tmp/homebrew-install.sh \
      https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh && \
    bash /tmp/homebrew-install.sh && \
    rm /tmp/homebrew-install.sh && \
    /home/linuxbrew/.linuxbrew/bin/brew install \
      atuin \
      ansible-language-server \
      bash-language-server \
      bat \
      fd \
      fish \
      fzf \
      gcc@11 \
      gh \
      git \
      git-delta \
      hadolint \
      lazygit \
      lsd \
      lua-language-server \
      neovim \
      node \
      ripgrep \
      ruby \
      shellcheck \
      starship \
      stow \
      stylua \
      tailwindcss-language-server \
      typescript-language-server \
      yaml-language-server \
      yazi \
      zoxide && \
    gem install \
      rbs \
      ruby-lsp \
      ruby-lsp-rails && \
    npm install --global \
      vscode-css-languageservice \
      vscode-html-languageservice \
      vscode-json-languageservice

USER root

RUN userdel linuxbrew
