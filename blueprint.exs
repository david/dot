defmodule Sys.Blueprint do
  use Habitat.Blueprint

  @os :tumbleweed

  def containers do
    [ar(), habitat(), sys()]
  end

  def ar do
    %{
      id: :ar,
      os: @os,
      root: root(:ar),
      modules:
        modules([
          :heroku,
          mysql: "8.0",
          nodejs: [
            package_manager: :yarn,
            version: "18"
          ],
          ruby: "3.3"
        ])
    }
  end

  def habitat do
    %{
      id: :habitat,
      os: @os,
      root: root(:habitat),
      modules: modules()
      # packages: packages() ++ ["elixir"]
    }
  end

  def sys do
    %{
      id: :sys,
      os: @os,
      root: root(:sys),
      modules: modules()
      # packages: packages() ++ ["elixir", "stylua", "lua-language-server"]
    }
  end

  defp modules(custom \\ []) do
    custom ++
      [
        atuin(),
        :bash,
        :bat,
        :fd,
        :fish,
        :fzf,
        gh(),
        :git,
        :git_delta,
        :lazygit,
        lsd(),
        neovim(),
        :ripgrep,
        starship(),
        wezterm(),
        :wl_clipboard,
        :zoxide,
        :zsh
      ]
  end

  defp atuin do
    {:atuin,
     [
       config: [
         enter_accept: true,
         inline_height: 16,
         keymap_mode: "vim-insert",
         keymap_cursor: %{
           "vim_insert" => "steady-bar",
           "vim_normal" => "steady-block"
         },
         daemon: [
           enabled: false
         ],
         sync: [
           records: true
         ]
       ]
     ]}
  end

  defp gh do
    {:github_cli,
     [
       config: [
         git_protocol: "https",
         version: "1"
       ]
     ]}
  end

  defp lsd do
    {:lsd,
     [
       alias: :default,
       config: [
         classic: false,
         icons: [
           separator: "  "
         ],
         sorting: [
           dir_grouping: "first"
         ]
       ]
     ]}
  end

  defp neovim do
    {:neovim,
     [
       config: path("config/nvim")
     ]}
  end

  defp starship do
    {:starship,
     [
       config: [
         format: "$fill $directory $git_branch$fill\\n$character",
         directory: [
           before_repo_root_style: "white",
           repo_root_style: "cyan",
           style: "bold yellow",
           truncate_to_repo: false,
           truncation_length: 30
         ],
         fill: [
           symbol: "─"
         ],
         git_branch: [
           format: "[$symbol$branch]($style) ",
           style: "cyan"
         ]
       ]
     ]}
  end

  defp wezterm do
    {:wezterm,
     [
       config: path("config/wezterm"),
       export: true
     ]}
  end

  def root(id) do
    "/var/home/david/#{id}"
  end
end
