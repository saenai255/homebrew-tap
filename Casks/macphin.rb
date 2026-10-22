cask "macphin" do
  version "0.1.2"
  sha256 "5f1ad0e3183a9ab133cb85901a1bd83ef7d6ff5bcbdd25a04f33789c8f4d86bc"

  url "https://github.com/saenai255/macphin/releases/download/v#{version}/Macphin-#{version}.dmg"
  name "Macphin"
  desc "Dolphin-style file manager"
  homepage "https://github.com/saenai255/macphin"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :sequoia"

  app "Macphin.app"

  # Not notarized by Apple; without this Gatekeeper refuses to open it.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/Macphin.app"],
        writable_paths: ["{{appdir}}/Macphin.app"]
  end

  uninstall quit: "dev.macphin.Macphin"

  zap trash: [
    "~/Library/Caches/dev.macphin.Macphin",
    "~/Library/Preferences/dev.macphin.Macphin.plist",
  ]
end
