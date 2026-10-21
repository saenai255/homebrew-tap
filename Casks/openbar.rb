cask "openbar" do
  version "1.0.1"
  sha256 "501a9ba9222fcbb240d2bdc19d36501095713a8e12306f25772eff7fc1c85c7d"

  url "https://github.com/saenai255/openbar/releases/download/v#{version}/OpenBar-#{version}.dmg"
  name "OpenBar"
  desc "Windows-style taskbar"
  homepage "https://github.com/saenai255/openbar"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :tahoe

  app "OpenBar.app"

  # Not notarized by Apple; without this Gatekeeper refuses to open it.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/OpenBar.app"],
        writable_paths: ["{{appdir}}/OpenBar.app"]
  end

  uninstall quit: "com.openbar.OpenBar"

  zap trash: [
    "~/Library/Caches/com.openbar.OpenBar",
    "~/Library/Preferences/com.openbar.OpenBar.plist",
  ]
end
