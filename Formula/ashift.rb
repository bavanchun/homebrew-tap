class Ashift < Formula
  desc "Command-line interface and Model Context Protocol (MCP) server for AriadShift (ashift)"
  homepage "https://github.com/bavanchun/AriadShift"
  version "0.7.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/bavanchun/AriadShift/releases/download/v0.7.0/ariad-cli-aarch64-apple-darwin.tar.xz"
      sha256 "3dd6f7a542282c418aa3480c7afa13e45bd47ee335b5ef4ac901fcb4737a54b4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bavanchun/AriadShift/releases/download/v0.7.0/ariad-cli-x86_64-apple-darwin.tar.xz"
      sha256 "7160237cd4036cd3e2a08a9669325339418e59f3fbbd2c888770a79cc32b0e50"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/bavanchun/AriadShift/releases/download/v0.7.0/ariad-cli-aarch64-unknown-linux-musl.tar.xz"
      sha256 "eb8a3c7b38fcd5a071b38df121f6bff552a5c1a87521134377617a799c729b37"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bavanchun/AriadShift/releases/download/v0.7.0/ariad-cli-x86_64-unknown-linux-musl.tar.xz"
      sha256 "1600f55a822f9c46ca40fa7168fdef649cf0f94bd682fed7c3c43caaea7832d4"
    end
  end
  license "Apache-2.0"
  depends_on "pandoc"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-pc-windows-gnu":              {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "ashift"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "ashift"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "ashift"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "ashift"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
