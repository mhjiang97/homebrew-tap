cask "caffeinate" do
  version "0.0.1"
  sha256 "ea21e2f27b0606c264145d398b9552dd27efc870f7698d879134c6394f88d690"

  url "https://github.com/mhjiang97/Caffeinate/releases/download/v#{version}/Caffeinate.zip"
  name "Caffeinate"
  desc "Menu bar wrapper for /usr/bin/caffeinate"
  homepage "https://github.com/mhjiang97/Caffeinate"

  app "Caffeinate.app"

  postflight do
    system_command "/usr/bin/xattr", args: ["-d", "com.apple.quarantine", "#{appdir}/Caffeinate.app"]
  end

  zap trash: [
    "~/Library/Preferences/com.mjhk.Caffeinate.plist",
  ]
end
