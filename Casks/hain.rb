cask "hain" do
  version "0.1.0"
  sha256 "413ed16e5079687b37f782e895358c2fd17f283ccd778e4400dd8d21cac9390b"

  url "https://volker.tech/hain/releases/Hain-#{version}.zip"
  name "Hain"
  desc "Indexes every file on the Mac and shows what takes space"
  homepage "https://volker.tech/hain/"

  depends_on macos: ">= :golden_gate"
  depends_on arch: :arm64

  app "Hain.app"
  # hain finds its sandboxed rules helper beside itself, so it's linked, never copied.
  binary "#{appdir}/Hain.app/Contents/Helpers/hain"

  # The background agent's registration stays as it is: Homebrew runs uninstall blocks on upgrade
  # too, and an upgrade must leave the agent on. The caveats say how to turn it off first.
  uninstall quit: "tech.volker.hain"

  zap trash: [
    "~/Library/Application Support/Hain",
    "~/Library/Caches/tech.volker.hain.agent",
    "~/Library/Caches/tech.volker.hain.search",
    "~/Library/Containers/tech.volker.hain.rules",
    "~/Library/Preferences/tech.volker.hain.plist",
  ]

  caveats <<~EOS
    Open Hain and turn on its background agent in Hain's Settings; it keeps the index current.
    Give Hain Full Disk Access first to index folders such as Mail's and Safari's.

    Before uninstalling, turn the agent off in Hain's Settings, or run:
      "#{appdir}/Hain.app/Contents/MacOS/Hain" agent unregister
  EOS
end
