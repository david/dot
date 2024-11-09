FROM quay.io/toolbx-images/opensuse-toolbox:tumbleweed

LABEL com.github.containers.toolbox="true" \
      usage="This image is meant to be used with the toolbox or distrobox command" \
      summary="A cloud-native terminal experience" \
      maintainer="david@davidleal.com"

RUN rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc && \
    zypper addrepo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo && \
    zypper dup -y && \
    zypper install -y -t pattern devel_basis && \
    zypper install -y \
      atuin \
      bat brave-browser \
      direnv \
      fd fish fzf \
      gh git git-delta \
      lazygit lsd lua-language-server \
      neovim nodejs npm \
      ripgrep ruby ruby-devel \
      ShellCheck starship stow StyLua \
      yarn yazi \
      zoxide && \
    npm install --global \
      @ansible/ansible-language-server \
      @olrtg/emmet-language-server \
      @tailwindcss/language-server \
      bash-language-server \
      typescript \
      vscode-langservers-extracted \
      yaml-language-server && \
    gem update --system 3.5.23 && \
    gem install ruby-lsp && \
    gem install ruby-lsp-rails && \
    ln -s /usr/bin/distrobox-host-exec /usr/local/bin/podman && \
    ln -s /usr/bin/distrobox-host-exec /usr/local/bin/ssh && \
    ln -s /usr/bin/distrobox-host-exec /usr/local/bin/systemctl

