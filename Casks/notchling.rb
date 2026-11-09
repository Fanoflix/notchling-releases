cask "notchling" do
  version "1.5.2"
  sha256 "1cd555c07b8fae223d71ed29bbc728ea8d47f57cdab3170c1e5a372d79447e50"

  url "https://github.com/Fanoflix/notchling-releases/releases/download/v#{version}/Notchling-#{version}.zip"
  name "Notchling"
  desc "Shows which Claude Code session needs you, in the notch"
  homepage "https://github.com/Fanoflix/notchling-releases"

  depends_on macos: ">= :sonoma"

  app "Notchling.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args:         ["-dr", "com.apple.quarantine", "#{appdir}/Notchling.app"],
                   must_succeed: false
  end

  uninstall quit: "com.fanoflix.notchling"

  zap script: {
        executable:   "#{Dir.home}/.notchling/bin/notchling-hook",
        args:         ["--disconnect"],
        must_succeed: false,
      },
      trash:  [
        "~/.notchling",
        "~/Library/Preferences/com.fanoflix.notchling.plist",
      ]
end
