cask "mount-manager" do
  version "0.0.1"
  sha256 "0b73dcfd9d251fdb5c514c0faffc586df9a56630c1aea03e299b0c60627c9333"

  url "https://github.com/mhjiang97/MountManager/releases/download/v#{version}/MountManager.zip"
  name "MountManager"
  desc "Menu bar app for managing oxfs SSHFS mounts"
  homepage "https://github.com/mhjiang97/MountManager"

  depends_on cask: "macfuse"

  app "MountManager.app"

  postflight do
    system_command "/usr/bin/xattr", args: ["-d", "com.apple.quarantine", "#{appdir}/MountManager.app"]
    system "pipx", "install", "oxfs" unless system("/usr/bin/which", "-s", "oxfs")
  end

  zap trash: [
    "~/Library/Preferences/com.mountmanager.app.plist",
  ]

  caveats <<~EOS
    MountManager requires oxfs (installed via pipx) and macFUSE.

    To start at login, add MountManager via System Settings > General > Login Items.
  EOS
end
