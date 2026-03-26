cask "mount-manager" do
  version "0.0.1.2"
  sha256 "d3d5c9c758606daae8bcf54e4b83a571b93672f63c114a1273342bb881f82ea1"

  url "https://github.com/mhjiang97/MountManager/releases/download/v#{version}/MountManager.zip"
  name "MountManager"
  desc "Menu bar app for managing oxfs SSHFS mounts"
  homepage "https://github.com/mhjiang97/MountManager"

  depends_on cask: "macfuse"
  depends_on formula: "pipx"

  app "MountManager.app"

  postflight do
    system_command "/usr/bin/xattr", args: ["-d", "com.apple.quarantine", "#{appdir}/MountManager.app"]
    system_command "#{HOMEBREW_PREFIX}/bin/pipx", args: ["install", "oxfs"]
  end

  zap trash: [
    "~/Library/Preferences/com.mountmanager.app.plist",
  ]

  caveats <<~EOS
    MountManager requires oxfs (installed via pipx) and macFUSE.

    To start at login, add MountManager via System Settings > General > Login Items.
  EOS
end
