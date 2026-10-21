cask "openbar" do
  version "1.2.1"
  sha256 "cce370c98c91f386dd6695de78b5975a9542ff03a3f253adc264a6841c566a68"

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
