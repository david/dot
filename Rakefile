# frozen_string_literal: true

HOME = ENV["HOME"]

PKGS_ALL = %w{atuin bat direnv fd fish fzf ripgrep starship zoxide}
PKGS_CONTAINER = PKGS_ALL | %w{delta lazygit neovim}

PKGS = {
  "host" => PKGS_ALL,
  "ar" => PKGS_CONTAINER | %w{mysql@8.0},
  "sys" => PKGS_CONTAINER
}

DIRS = {
  "#{HOME}/.local/share/backgrounds" => "backgrounds",
  "#{HOME}/.config" => "config",
  "#{HOME}/.local/bin/sys-setup" => "scripts/setup",
}

BREW = "/home/linuxbrew/.linuxbrew/bin/brew"
TARGET = ENV["CONTAINER_ID"] || "host"

IMAGE = "ghcr.io/david/devbox:latest"

desc "Setup current environment"
task :setup => "setup:default"

namespace :image do
  task :create do
    sh "distrobox", "create",
      "--home=#{File.join(HOME, "Projects")}",
      "--image=#{IMAGE}",
      "--name=",
      "--pull",
      "--yes"
  end
end

namespace :setup do
  task default: ["clean", *DIRS.keys, "packages:#{TARGET}"]

  task :clean do
    DIRS.keys.each { |f| rm_f f }
  end

  DIRS.each do |k, v|
    file k => v do |t|
      ln_s File.expand_path(t.source), t.name
    end
  end

  namespace :packages do
    PKGS.each do |target, pkgs|
      task target do
        sh BREW, "install", "--quiet", *pkgs
      end
    end
  end
end
