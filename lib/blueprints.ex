defmodule Blueprints do
  def containers do
    [
      %{
        name: "habitat",
        packages: packages() ++ ["elixir"]
      },
      %{
        name: "sys",
        packages: packages() ++ ["elixir", "stylua", "lua-language-server"]
      },
      %{name: "test"}
    ]
    |> Enum.map(&container/1)
  end

  defp container(opts) do
    Map.merge(
      opts,
      %{
        exports: exports(),
        files: files(),
        home: devenv_path(opts.name),
        os: :archlinux,
        packages: Map.get(opts, :packages, packages())
      }
    )
  end

  defp devenv_path(name) do
    [System.user_home(), "..", name] |> Path.join() |> Path.expand()
  end

  defp exports do
    [
      "wezterm"
    ]
  end

  defp files do
    %{
      "~/.config/dircolors" => "files/dircolors",
      "~/.config/gh" => "files/gh",
      "~/.local/share/fonts" => "fonts",
      "~/.config/nvim" => "files/nvim",
      "~/.config/starship.toml" => "files/starship.toml"
    }
  end

  defp packages do
    [
      "atuin",
      "base-devel",
      "bash",
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
      "starship",
      "ttf-nerd-fonts-symbols-mono",
      "wl-clipboard",
      "zoxide",
      "wezterm"
    ]
  end
end
