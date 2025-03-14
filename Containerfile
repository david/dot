FROM ghcr.io/ublue-os/arch-distrobox:latest

LABEL com.github.containers.toolbox="true" \
      usage="This image is meant to be used with the toolbox or distrobox command" \
      summary="A cloud-native terminal experience" \
      maintainer="david@davidleal.com"

RUN echo -e "LANG=en_US.UTF-8\nLANGUAGE=en_US:en" > /etc/locale.conf && \
    echo -e "en_US.UTF-8 UTF-8\npt_PT.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen

RUN pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com && \
    pacman-key --lsign-key 3056513887B78AEB && \
    pacman -U --noconfirm https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst \
      https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst && \
    echo -e "[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist" >> /etc/pacman.conf

RUN pacman -Syu --noconfirm && \
    pacman -Syu --noconfirm --needed \
      atuin \
      base-devel bat blesh-git brave-browser \
      direnv \
      eza \
      fd fzf \
      git git-delta github-cli \
      jq \
      kitty \
      lazygit \
      mise \
      neovim nodejs npm \
      ripgrep \
      starship stow \
      ttf-nerd-fonts-symbols-mono ttf-jetbrains-mono \
      usage \
      wl-clipboard \
      yazi

RUN useradd build
USER build
WORKDIR /tmp/yay-bin
RUN git clone https://aur.archlinux.org/yay-bin.git . && \
    makepkg --noconfirm
USER root
RUN pacman -U --noconfirm yay-bin-*-x86_64.pkg.tar.zst && \
    pacman -Rns yay-bin-debug --noconfirm
WORKDIR /tmp
RUN rm -fr yay-bin && \
    userdel build

RUN ln -sf /usr/bin/distrobox-host-exec /usr/local/bin/podman && \
    ln -sf /usr/bin/distrobox-host-exec /usr/local/bin/distrobox

USER 1000:1000
