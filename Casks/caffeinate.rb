cask "caffeinate" do
  version "0.0.1.2"
  sha256 "522eff2a68b5e5015f77691699eb32fb6cd2ded3cb6c5ebdbc3a926179a05741"

  url "https://github.com/mhjiang97/Caffeinate/releases/download/v#{version}/Caffeinate.zip"
  name "Caffeinate"
  desc "Menu bar wrapper for /usr/bin/caffeinate"
  homepage "https://github.com/mhjiang97/Caffeinate"

  depends_on macos: :tahoe

  app "Caffeinate.app"

  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-d", "com.apple.quarantine", "{{appdir}}/Caffeinate.app"],
        must_succeed: false
  end

  zap trash: "~/Library/Preferences/com.mjhk.Caffeinate.plist"
end
