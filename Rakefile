PACKAGES = %w[
  atuin
  direnv
  eza
  fd fzf
  gcc@11 gh git-delta
  heroku
  html-xml-utils
  lazydocker lazygit
  neovim node nushell
  ripgrep ruby-build
  starship
  yazi
]

STOW_MAPPINGS = (
  FileList["packages/*/config/**/*"].
    filter { |path| path !~ %r{packages/starship} && path !~ %r{packages/bash} && File.file?(path) }.
    map { |path|
      _, pkg, _, *rest = path.split("/")

      [ "#{ENV["HOME"]}/.config/#{pkg}/#{rest.join("/")}", path ]
    } +
    [
      [ "~/.config/starship.toml", "packages/starship/config/starship.toml" ],
      [ "~/.bashrc", "packages/bash/config/bashrc" ],
      [ "~/.bash_profile", "packages/bash/config/bash_profile" ]
    ]
  ).
  map { |dest, src| [ File.expand_path(dest), File.expand_path(src) ] }.
  to_h

STOW_MAPPINGS.each do |dest, src|
  file dest => src do
    mkdir_p File.dirname(dest)
    ln_sf src, dest
  end
end

task :stow => STOW_MAPPINGS.keys

namespace :stow do
  task :clobber do
    STOW_MAPPINGS.keys.each do |dest|
      rm_f dest
    end
  end
end

namespace :project do
  task :launchers do
    project_name = ENV["PROJECT"]
    project_path = "#{ENV["HOME"]}/Projects/#{project_name}"
    tree_paths = ENV["TREE"] ? [ "#{project_path}/#{ENV["TREE"]}" ] : FileList["#{project_path}/*"]

    raise "unknown directory #{tree_paths.first}" unless File.directory?(tree_paths.first)

    tree_paths.each do |tree_path|
      session_path = File.expand_path("projects/#{project_name}/kitty/session.conf")
      session_opt = "--session=#{session_path}" if File.exist?(session_path)
      tree_name = File.basename(tree_path)
      content = <<~DESKTOP
        [Desktop Entry]
        Version=1.0
        Type=Application
        Name=#{project_name}  #{tree_name}
        TryExec=kitty
        StartupNotify=true
        Exec=kitty --directory=#{tree_path} #{session_opt}
        DESKTOP
      launcher_path = "#{ENV["HOME"]}/.local/share/applications/#{project_name}-#{tree_name}.desktop"

      puts "writing #{launcher_path}"
      File.write launcher_path, content
    end
  end
end

task :packages do
  installed = `brew list`.lines(chomp: true)
  wanted = PACKAGES - installed

  sh "brew install #{wanted.join(" ")}" unless wanted.empty?
end
