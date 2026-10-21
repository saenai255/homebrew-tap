cask "openbar" do
  version "1.0.0"
  sha256 "92b446b8296d4c8dd15659fd31c8121b16b8dac345260f28fd2c09b1b6007b4d"

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
