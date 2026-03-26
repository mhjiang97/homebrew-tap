cask "mount-manager" do
  version "0.0.1.1"
  sha256 "ea81dd9929e4929019ef32e327c50e7ff09c42b81a21f1aa2a78ca6adf39fd3b"

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
