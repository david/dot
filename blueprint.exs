defmodule Sys.Blueprint do
  use Habitat.Blueprint

  defp container(opts) do
    Map.merge(
      opts,
      %{
        modules: modules() ++ Map.get(opts, :modules, []),
        os: :tumbleweed,
        root: Path.join("/var/home/david", to_string(opts.id))
      }
    )
  end

  def containers do
    Enum.map(
      [
        %{
          id: :ar,
          modules: [
            :heroku,
            mysql: "8.0",
            nodejs: [
              package_manager: :yarn,
              version: "18"
            ],
            ruby: "3.3"
          ]
        },
        %{
          id: :habitat
          # packages: packages() ++ ["elixir"]
        },
        %{
          id: :sys
          # packages: packages() ++ ["elixir", "stylua", "lua-language-server"]
        }
      ],
      &container/1
    )
  end

  defp modules do
    [
      atuin(),
      :bash,
      :bat,
      :fd,
      :fzf,
      gh(),
      :git,
      :git_delta,
      :lazygit,
      lsd(),
      neovim(),
      :ripgrep,
      starship(),
      :wl_clipboard,
      :zoxide,
      zsh()
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

  defp zsh do
    {:zsh,
     [
       default: true
     ]}
  end
end
