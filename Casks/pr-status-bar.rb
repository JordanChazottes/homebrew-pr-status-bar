cask "pr-status-bar" do
  version "0.1.0"
  sha256 "2bd041cc62b665569ea3d7ff684fcf4de4e22aff1b7f16e55d093efea937bd30"

  url "https://github.com/JordanChazottes/pr-status-bar/releases/download/v#{version}/PRStatusBar-#{version}.zip"
  name "PR Status Bar"
  desc "Menu bar app showing the review status of your open GitHub pull requests"
  homepage "https://github.com/JordanChazottes/pr-status-bar"

  depends_on arch: :arm64
  depends_on macos: ">= :ventura"
  depends_on formula: "gh"

  app "PRStatusBar.app"

  # Ad-hoc signed, not notarized: drop the quarantine flag so Gatekeeper
  # doesn't block the first launch.
  postflight do
    system_command "/usr/bin/xattr",
                   args:         ["-cr", "#{appdir}/PRStatusBar.app"],
                   must_succeed: false
  end

  uninstall quit: "dev.jordanchazottes.pr-status-bar"

  caveats <<~EOS
    PR Status Bar reads your PRs through the gh CLI. If you haven't yet:

      gh auth login

    Then launch it with:  open -a PRStatusBar
  EOS
end
