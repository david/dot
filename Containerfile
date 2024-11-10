FROM quay.io/toolbx/ubuntu-toolbox:24.10

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
ENV PATH /home/linuxbrew/.linuxbrew/bin:$PATH

RUN curl -fsSLo \
      /usr/share/keyrings/brave-browser-archive-keyring.gpg \
      https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg && \
    echo -n "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] " \
      "https://brave-browser-apt-release.s3.brave.com/ stable main" > \
      /etc/apt/sources.list.d/brave-browser-release.list && \
    apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y adwaita-icon-theme build-essential brave-browser locales wl-clipboard && \
    rm -fr /var/lib/apt/lists/* /var/cache/apt/archives/* && \
    localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 && \
    curl -fsSLo /tmp/homebrew-install.sh https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh && \
    bash /tmp/homebrew-install.sh && \
    rm /tmp/homebrew-install.sh && \
    brew install \
      atuin \
      bat \
      direnv \
      fd fish fzf \
      gcc@11 gh git git-delta \
      lazygit lsd lua-language-server \
      neovim node \
      ripgrep ruby \
      shellcheck starship stow stylua \
      yarn yazi \
      zoxide && \
    gem install ruby-lsp && \
    gem install ruby-lsp-rails && \
    npm install --global \
      bash-language-server \
      typescript \
      vscode-langservers-extracted \
      @ansible/ansible-language-server \
      @olrtg/emmet-language-server \
      @tailwindcss/language-server && \
    yarn global add yaml-language-server && \
    chown -R 1000:1000 /home/linuxbrew

