class Ashift < Formula
  desc "Command-line interface and Model Context Protocol (MCP) server for AriadShift (ashift)"
  homepage "https://github.com/bavanchun/AriadShift"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/bavanchun/AriadShift/releases/download/v0.3.0/ariad-cli-aarch64-apple-darwin.tar.xz"
      sha256 "2d658d3d5d4d30aab9c39746ca0fc45f85010eb8cf9ebdde5b8c775217ff17df"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bavanchun/AriadShift/releases/download/v0.3.0/ariad-cli-x86_64-apple-darwin.tar.xz"
      sha256 "fb789a98b931608e4eb73c72dcf6091ab33b43d54a8ed604de332b6796f9c6f7"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/bavanchun/AriadShift/releases/download/v0.3.0/ariad-cli-aarch64-unknown-linux-musl.tar.xz"
      sha256 "28a616caf5c2079a3fe7dbe4cbac6c7484c041028de56c4a5389917b98746b6c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bavanchun/AriadShift/releases/download/v0.3.0/ariad-cli-x86_64-unknown-linux-musl.tar.xz"
      sha256 "68037d3c1ccf254ea5f928b5eebfe3e0919425b6f25c789c3a052c38c620c158"
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
