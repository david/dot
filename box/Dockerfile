FROM ghcr.io/ublue-os/arch-toolbox:latest

ARG GID=1000
ARG UID=1000
ARG USER=david

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    echo "pt_PT.UTF-8 UTF-8" >> /etc/locale.gen && \
    echo "LANG=en_US.UTF-8" > /etc/locale.conf && \
    locale-gen

RUN groupadd --gid ${GID} ${USER} && \
    useradd --create-home --uid ${UID} --gid ${GID} ${USER}

RUN pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com && \
    pacman-key --lsign-key 3056513887B78AEB && \
    pacman -U --noconfirm \
      'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' \
      'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' && \
    echo "[chaotic-aur]" >> /etc/pacman.conf && \
    echo "Include = /etc/pacman.d/chaotic-mirrorlist" >> /etc/pacman.conf

RUN pacman -Syu --noconfirm \
      base-devel \
      bat \
      bitwarden-cli \
      blesh-git \
      eza \
      fd \
      fzf \
      github-cli \
      inotify-tools \
      jq \
      lazydocker \
      lazygit \
      mise \
      neovide \
      ripgrep \
      starship \
      ttf-jetbrains-mono \
      ttf-nerd-fonts-symbols \
      usage \
      wl-clipboard \
      yay

# ruby
RUN pacman -S --noconfirm \
      libyaml

WORKDIR /tmp

# process-compose
RUN mkdir process-compose && \
    curl -fSsL -o process-compose.tgz \
      https://github.com/F1bonacc1/process-compose/releases/latest/download/process-compose_linux_amd64.tar.gz && \
    tar -xvf process-compose.tgz --directory=process-compose && \
    cp process-compose/process-compose /usr/local/bin && \
    rm -fr process-compose process-compose.tgz

# mailpit
RUN mkdir mailpit && \
    curl -fSsL -o mailpit.tgz \
      https://github.com/axllent/mailpit/releases/latest/download/mailpit-linux-amd64.tar.gz && \
    tar -xvf mailpit.tgz --directory=mailpit && \
    cp mailpit/mailpit /usr/local/bin && \
    rm -fr mailpit mailpit.tgz
