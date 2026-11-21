cask "mount-manager" do
  version "0.0.1.4"
  sha256 "fb93902c393b6c8f12a7463c06b2c8d2feba3cf3d39fdae79a98ca879dbd11f0"

  url "https://github.com/mhjiang97/MountManager/releases/download/v#{version}/MountManager.zip"
  name "MountManager"
  desc "Menu bar app for managing oxfs SSHFS mounts"
  homepage "https://github.com/mhjiang97/MountManager"

  depends_on cask: "macfuse"
  depends_on formula: "pipx"
  depends_on macos: :tahoe

  app "MountManager.app"

  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-d", "com.apple.quarantine", "{{appdir}}/MountManager.app"],
        must_succeed: false
    # Steps run with a throwaway HOME, so point pipx back at the user's real home,
    # where MountManager looks for oxfs (~/.local/bin). The pip backend keeps the
    # writable paths predictable; pipx would otherwise pick up uv if installed.
    run "/bin/sh",
        args:           ["-c", 'HOME=~{{user}} exec "$0" install oxfs', "{{HOMEBREW_PREFIX}}/bin/pipx"],
        env:            { "PIPX_DEFAULT_BACKEND" => "pip" },
        network_access: true,
        writable_paths: [
          ".local/pipx",
          ".local/bin",
          ".local/share/man",
          "Library/Caches/pip",
          "Library/Caches/pipx",
          "Library/Logs/pipx",
        ],
        writable_base:  :home
  end

  zap trash: "~/Library/Preferences/com.mountmanager.app.plist"

  caveats <<~EOS
    MountManager requires oxfs (installed via pipx) and macFUSE.
  EOS
end
