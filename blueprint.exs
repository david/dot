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
      editing_mode: :vi,
      modules:
        modules(:ar, [
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
      editing_mode: :vi,
      os: @os,
      root: root(:habitat),
      modules: modules(:habitat)
    }
  end

  def sys do
    %{
      id: :sys,
      editing_mode: :vi,
      os: @os,
      root: root(:sys),
      modules: modules(:sys)
    }
  end

  defp modules(id, custom \\ []) do
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
        starship(id),
        wezterm(),
        :wl_clipboard,
        :zoxide
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

  defp starship(id) do
    bg = "#3c3836"
    before_root = "[󰋜 $before_root_path]($before_repo_root_style)"
    repo = "[󰔱 $repo_root]($repo_root_style)"
    path = "[$path]($style)"
    ro = "[$read_only]($read_only_style)"
    sep = "[ ∙ ](fg:white bg:#{bg})"
    spc = "[ ](bg:#{bg})"

    {:starship,
     [
       config: [
         format:
           "$fill[](#{bg})#{spc}$directory$git_branch$git_status#{spc}[](#{bg})$fill\\n$character",
         directory: [
           before_repo_root_style: "fg:bright-yellow bg:#{bg}",
           repo_root_format: "#{before_root}#{sep}#{repo}#{sep}#{path}#{ro}",
           repo_root_style: "fg:bright-purple bg:#{bg}",
           style: "green",
           truncate_to_repo: false,
           truncation_length: 30
         ],
         "directory.substitutions": [
           "'~/'": "#{id}",
           "'trees/'": ""
         ],
         fill: [
           symbol: "─",
           style: bg
         ],
         git_branch: [
           format: "[$symbol$branch]($style)",
           style: "fg:bright-green bg:#{bg}",
           symbol: "󰘬 "
         ],
         git_status: [
           format:
             "[\\\\[](fg:white bg:#{bg})[$all_status$ahead_behind]($style)[\\\\]](fg:white bg:#{bg})",
           style: "fg:bold bright-green bg:#{bg}",
           ahead: "󰜝",
           behind: "󰜙",
           conflicted: "",
           diverged: " ",
           deleted: "",
           modified: "",
           renamed: "",
           staged: "",
           stashed: "",
           up_to_date: "✓"
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
