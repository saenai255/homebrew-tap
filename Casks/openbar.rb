cask "openbar" do
  version "1.2.0"
  sha256 "f51d9d4d676194fe11ee5a2e2a3e234e105c74665229a1dbff1b4ca54a81e919"

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
