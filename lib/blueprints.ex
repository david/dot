defmodule Blueprints do
  def containers do
    Enum.map(
      [
        %{
          name: "ar",
          packages: packages() ++ ["heroku", "opentofu"],
          programs: [
            mysql: "8.0",
            nodejs: [
              package_manager: :yarn,
              version: "18"
            ],
            ruby: "3.3"
          ],
          files: files()
        },
        %{
          name: "habitat",
          packages: packages() ++ ["elixir"]
        },
        %{
          name: "sys",
          packages: packages() ++ ["elixir", "stylua", "lua-language-server"]
        },
        %{
          name: "test",
          programs: [
            mysql: "8.0"
          ]
        }
      ],
      &container/1
    )
  end

  defp programs do
    [
      :atuin,
      :mise,
      :starship,
      :zoxide
    ]
  end

  defp exports do
    [
      "wezterm"
    ]
  end

  defp files do
    [
      {"containers/ar/files/**", "~/.config"},
      {"files/**", "~/.config"},
      {"fonts/*", "~/.local/share/fonts"}
    ]
  end

  defp packages do
    [
      "base-devel",
      "bat",
      "fd",
      "fzf",
      "git",
      "git-delta",
      "github-cli",
      "glibc-locales",
      "lazygit",
      "lsd",
      "neovim",
      "noto-fonts-emoji",
      "ripgrep",
      "shared-mime-info",
      "ttf-nerd-fonts-symbols-mono",
      "wl-clipboard",
      "wezterm"
    ]
  end

  defp container(opts) do
    Map.merge(
      opts,
      %{
        # missing:
        # elasticsearch via tarball (aur?)
        # make glibc-locale, man-db, base-devel installable without appearing in :packages
        # brew install f1bonacc1/tap/process-compose
        exports: exports(),
        programs: programs() ++ Map.get(opts, :programs, []),
        files: Map.get(opts, :files, files()),
        os: Habitat.OS.ArchLinux,
        packages: Map.get(opts, :packages, packages()),
        root: [System.user_home(), "..", opts.name] |> Path.join() |> Path.expand(),
        shells: [:zsh, :bash]
      }
    )
  end
end
