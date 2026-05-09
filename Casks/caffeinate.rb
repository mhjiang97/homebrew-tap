cask "caffeinate" do
  version "0.0.1.1"
  sha256 "3ee36b1bf07d1c5fb31bd86ef99ac9e56fcedf62e814d87c3d1ebd67eba2a155"

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
