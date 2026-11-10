class Ashift < Formula
  desc "Command-line interface and Model Context Protocol (MCP) server for AriadShift (ashift)"
  homepage "https://github.com/bavanchun/AriadShift"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/bavanchun/AriadShift/releases/download/v0.5.0/ariad-cli-aarch64-apple-darwin.tar.xz"
      sha256 "1b7263fb31a866b3ca50a3ca93c9f6c3da9158195185bc00a286c003305b555d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bavanchun/AriadShift/releases/download/v0.5.0/ariad-cli-x86_64-apple-darwin.tar.xz"
      sha256 "00a56a791dc0baa0cb6732854fc55a58ed2544dcb819632e764a3c94175471c3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/bavanchun/AriadShift/releases/download/v0.5.0/ariad-cli-aarch64-unknown-linux-musl.tar.xz"
      sha256 "3c8cc22cdc546e43fc097633efd3e002ef7d6d65887d04ea03b1209613177d05"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bavanchun/AriadShift/releases/download/v0.5.0/ariad-cli-x86_64-unknown-linux-musl.tar.xz"
      sha256 "3bdf7263277272c3252fb8b10380b41cdf26fe0b85c15eca963c40f34fae7a2a"
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
