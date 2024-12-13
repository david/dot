FROM quay.io/toolbx/ubuntu-toolbox:24.10

LABEL com.github.containers.toolbox="true" \
      usage="This image is meant to be used with the toolbox or distrobox command" \
      summary="A cloud-native terminal experience" \
      maintainer="david@davidleal.com"

ENV DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.utf8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.utf8 \
    NONINTERACTIVE=1 \
    USER_ID=1000 \
    PATH=/home/linuxbrew/.linuxbrew/bin:$PATH

RUN localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
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
    curl -fsSLo /tmp/homebrew-install.sh \
      https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh && \
    bash /tmp/homebrew-install.sh && \
    rm /tmp/homebrew-install.sh && \
    brew install \
      atuin \
      bat \
      direnv \
      eza \
      fd fish fzf \
      gcc@11 gh git git-delta \
      jq \
      lazygit \
      neovim node \
      ripgrep ruby \
      starship stow \
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
    curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin dest=/usr/local/kitty launch=n && \
    chown -R 1000:1000 /home/linuxbrew && \
    ln -s /usr/bin/distrobox-host-exec /usr/local/bin/journalctl && \
    ln -s /usr/bin/distrobox-host-exec /usr/local/bin/scp && \
    ln -s /usr/bin/distrobox-host-exec /usr/local/bin/ssh && \
    ln -s /usr/bin/distrobox-host-exec /usr/local/bin/systemctl && \
    ln -s /usr/bin/distrobox-host-exec /usr/local/bin/podman

USER 1000:1000
