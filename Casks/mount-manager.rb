cask "mount-manager" do
  version "0.0.1.1"
  sha256 "b771b7364c326a0ffbb2ee491af194a2c2659b66afaa5abf084d42759745f9d4"

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
  EOS
end
