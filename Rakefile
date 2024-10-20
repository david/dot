# frozen_string_literal: true

PKGS_COMMON = %w{atuin bat direnv fd fish fzf ripgrep starship zoxide}
PKGS_CONTAINER = %w{delta lazygit neovim}

HOME = ENV["HOME"]

BREW = "/home/linuxbrew/.linuxbrew/bin/brew"
TARGET = ENV["CONTAINER_ID"] || "host"

DIRS = {
  "#{HOME}/.local/share/backgrounds" => "backgrounds",
  "#{HOME}/.config" => "config",
  "#{HOME}/.local/bin/sys-setup" => "scripts/setup",
}

task :setup => "setup:default"

namespace :setup do
  task default: ["clean", *DIRS.keys, "packages:#{TARGET}"]

  desc "Clean links"
  task :clean do
    DIRS.keys.each { |f| rm_f f }
  end

  DIRS.each do |k, v|
    file k => v do |t|
      ln_s File.expand_path(t.source), t.name
    end
  end

  namespace :packages do
    task :all do
      sh "#{BREW} install --quiet #{PKGS_COMMON.join(" ")}"
    end

    task :container do
      sh "#{BREW} install --quiet #{PKGS_CONTAINER.join(" ")}"
    end

    task host: %{all}

    task ar: %w{all container}
    task sys: %w{all container}
  end
end
