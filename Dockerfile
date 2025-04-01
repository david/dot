FROM ghcr.io/ublue-os/arch-distrobox

RUN echo -e "LANG=en_US.UTF-8\nLANGUAGE=en_US:en" > /etc/locale.conf && \
    echo -e "en_US.UTF-8 UTF-8\npt_PT.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen && \
    pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com && \
    pacman-key --lsign-key 3056513887B78AEB && \
    pacman -U --noconfirm https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst \
      https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst && \
    echo -e "[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist" >> /etc/pacman.conf

RUN pacman -Syu --noconfirm && \
    pacman -Syu --noconfirm --needed \
      atuin \
      base-devel bat blesh-git brave-browser \
      eza \
      fd fzf \
      git git-delta github-cli \
      jq \
      kde-cli-tools kitty \
      lazygit \
      mise \
      neovim nodejs npm \
      ripgrep \
      starship stow stylua systemd \
      tailwindcss-language-server traefik ttf-nerd-fonts-symbols-mono ttf-jetbrains-mono \
      usage \
      vscode-css-languageserver vscode-html-languageserver vscode-json-languageserver \
      wl-clipboard \
      yay yazi && \
    pacman -S --clean --clean

RUN useradd -m --shell=/bin/bash build && \
    usermod -L build && \
    echo "build ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER build
WORKDIR /home/build

RUN yay -S hivemind-bin --noconfirm && \
    sudo pacman -S --clean --clean

USER root
WORKDIR /

RUN userdel -r build && \
    rm -drf /home/build && \
    sed -i '/build ALL=(ALL) NOPASSWD: ALL/d' /etc/sudoers
