class MountManager < Formula
  desc "macOS menu bar app for managing oxfs SSHFS mounts"
  homepage "https://github.com/mhjiang97/MountManager"
  url "https://github.com/mhjiang97/MountManager.git", tag: "v0.0.1"
  license "MIT"

  depends_on :macos
  depends_on "pipx" => :recommended

  def install
    # Build the binary
    system "swiftc",
           "-o", "MountManager",
           "-parse-as-library",
           "-framework", "SwiftUI",
           "-framework", "Security",
           "-framework", "AppKit",
           *Dir["MountManager/*.swift"]

    # Create app bundle
    app_contents = prefix/"MountManager.app/Contents"
    (app_contents/"MacOS").mkpath
    (app_contents/"Resources").mkpath
    cp "MountManager", app_contents/"MacOS/MountManager"
    cp "MountManager.icns", app_contents/"Resources/AppIcon.icns"
    (app_contents/"Info.plist").write <<~XML
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
        <key>CFBundleExecutable</key>
        <string>MountManager</string>
        <key>CFBundleIdentifier</key>
        <string>com.mountmanager.app</string>
        <key>CFBundleName</key>
        <string>MountManager</string>
        <key>CFBundleIconFile</key>
        <string>AppIcon</string>
        <key>CFBundlePackageType</key>
        <string>APPL</string>
        <key>CFBundleVersion</key>
        <string>#{version}</string>
        <key>CFBundleShortVersionString</key>
        <string>#{version}</string>
        <key>LSMinimumSystemVersion</key>
        <string>13.0</string>
        <key>LSUIElement</key>
        <true/>
      </dict>
      </plist>
    XML
  end

  def post_install
    # Install oxfs via pipx if not already available
    unless which("oxfs")
      system "pipx", "install", "oxfs"
    end
  end

  def caveats
    <<~EOS
      MountManager.app has been installed to:
        #{prefix}/MountManager.app

      To add to /Applications:
        ln -sf #{prefix}/MountManager.app /Applications/MountManager.app

      To start at login, add it via System Settings > General > Login Items.

      Dependencies:
        - oxfs (installed via pipx): SSHFS client using SSH and FUSE
        - macFUSE: required by oxfs, install via: brew install --cask macfuse
    EOS
  end
end
