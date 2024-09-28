defmodule Sys.Blueprint do
  use Habitat.Blueprint

  @home "/var/home/david"

  def hosts do
    [
      %{
        name: "timbuktu",
        root: @home,
        containers: Enum.map(containers(), &container/1),
        xdg: [
          user_dirs: false
        ]
      }
    ]
  end

  defp container(opts) do
    id = Map.get(opts, :id)

    %{
      id: id,
      root: Path.join(@home, to_string(id)),
      shell: :fish,
      service_manager: :process_compose,
      editing: [
        style: :vi,
        initial_mode: :insert,
        cursor: [
          shape: [
            insert: :bar,
            normal: :box
          ]
        ]
      ],
      files: [
        {"~/.local/bin/dev", link("scripts/dev")}
      ],
      modules: modules(id) ++ Map.get(opts, :modules, []),
      packages:
        [
          "fd",
          "gh",
          "lazygit",
          "ripgrep"
        ] ++ Map.get(opts, :packages, [])
    }
  end

  defp containers do
    [
      %{
        id: :ar,
        modules: [
          :brave,
          :heroku,
          nodejs: [
            package_manager: :yarn,
            version: "18"
          ],
          mysql: "8.0",
          ruby: "3.3"
        ],
        packages: [
          "opentofu"
        ]
      },
      %{id: :church, packages: ["nushell"]},
      %{id: :habitat, packages: ["elixir"]},
      %{id: :habitat_boxes},
      %{
        id: :sys,
        packages: [
          "elixir",
          "lua-language-server",
          "stylua"
        ]
      }
    ]
  end

  defp modules(id) do
    [
      :bat,
      :delta,
      :direnv,
      :fzf,
      :readline,
      :zoxide,
      atuin: atuin(),
      lsd: lsd(),
      neovim: [
        config: link("config/nvim/init.lua")
      ],
      starship: starship(id),
      wezterm: [
        config: link("config/wezterm/wezterm.lua"),
        export: true
      ]
    ]
  end

  defp atuin do
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
    ]
  end

  defp lsd do
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
    ]
  end

  defp starship(id) do
    bg = "#3c3836"
    before_root = "[$before_root_path]($before_repo_root_style)"
    repo = "[󰔱 $repo_root]($repo_root_style)"
    path = "[$path]($style)"
    ro = "[$read_only]($read_only_style)"
    sep = "[ ∙ ](fg:white bg:#{bg})"
    spc = "[ ](bg:#{bg})"

    no_repo_root = "[󰋜 #{id}]($before_repo_root_style)"
    no_repo_path = "[$path]($style)"

    [
      config: [
        format:
          "$fill[](#{bg})#{spc}$directory$git_branch$git_status#{spc}[](#{bg})$fill\\n$character",
        directory: [
          before_repo_root_style: "fg:bright-yellow bg:#{bg}",
          format: "#{no_repo_root}#{no_repo_path}",
          repo_root_format: "#{before_root}#{sep}#{repo}#{path}#{ro}#{sep}",
          repo_root_style: "fg:bright-purple bg:#{bg}",
          style: "fg:green bg:#{bg}",
          truncate_to_repo: false,
          truncation_length: 30
        ],
        "directory.substitutions": [
          "'~/'": "󰋜 #{id}",
          "'~'": ""
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
          untracked: "",
          up_to_date: "✓"
        ]
      ]
    ]
  end
end
