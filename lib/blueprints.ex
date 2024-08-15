defmodule Blueprints do
  def config do
    [
      %{
        name: "habitat",
        os: :archlinux,
        home: devenvs_path("habitat"),
        packages: packages() ++ ["elixir"],
        files: files()
      },
      %{
        name: "sys",
        os: :archlinux,
        home: devenvs_path("sys"),
        packages: packages(),
        files: files()
      }
    ]
  end

  defp devenvs_path(name) do
    Path.join([System.user_home(), "..", name])
  end

  defp files do
    %{
      "files/dircolors" => "~/.config/dircolors"
    }
  end

  defp packages do
    [
      "atuin",
      "bat",
      "fd",
      "git-delta",
      {"github-cli",
       files: %{
         "files/gh" => "~/.config/gh"
       }},
      "glibc-locales",
      "lazygit",
      "lsd",
      {"neovim",
       files: %{
         "files/neovim" => "~/.config/nvim"
       }},
      "noto-fonts-emoji",
      "ripgrep",
      {"starship",
       files: %{
         "files/starship.toml" => "~/.config/starship.toml"
       }},
      "ttf-nerd-fonts-symbols-mono",
      "wl-clipboard",
      "zoxide",
      {"wezterm", export: true}
    ]
  end
end
