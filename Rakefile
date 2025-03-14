namespace :home do
  task :launchers do
    containers_path = File.expand_path(File.join(ENV["HOME"], ".."))

    FileList["#{containers_path}/*"].each do |container_path|
      container_name = File.basename(container_path)
      launchers_path = "#{ENV["HOME"]}/../../.local/share/applications"

      FileList["#{launchers_path}/#{container_name}-*.desktop"].each do |launcher_path|
        sh "distrobox-host-exec xdg-desktop-menu uninstall #{launcher_path}"
      end

      FileList["#{container_path}/*"].each do |tree_path|
        tree_name = File.basename(tree_path)

        content = <<~DESKTOP
        [Desktop Entry]
        Version=1.0
        Type=Application
        Name=#{container_name}  #{tree_name}
        StartupNotify=true
        Exec=distrobox enter #{container_name} -- kitty --directory=#{tree_path} --session=session.conf
        DESKTOP

        launcher_path = "#{launchers_path}/#{container_name}-#{tree_name}.desktop"

        puts "writing #{launcher_path}"
        File.write launcher_path, content

        sh "distrobox-host-exec xdg-desktop-menu install #{launcher_path}"
      end
    end
  end
end
