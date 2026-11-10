class Ashift < Formula
  desc "Command-line interface and Model Context Protocol (MCP) server for AriadShift (ashift)"
  homepage "https://github.com/bavanchun/AriadShift"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/bavanchun/AriadShift/releases/download/v0.4.0/ariad-cli-aarch64-apple-darwin.tar.xz"
      sha256 "187130e9436862bae5f8034b21f32c088e8030b617db05ab09bd25ca0e6e57eb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bavanchun/AriadShift/releases/download/v0.4.0/ariad-cli-x86_64-apple-darwin.tar.xz"
      sha256 "234bdcf72bd751849b4ed61d2c5c58f0eeb6eed6798718f64393e4374ca4b7ca"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/bavanchun/AriadShift/releases/download/v0.4.0/ariad-cli-aarch64-unknown-linux-musl.tar.xz"
      sha256 "6d63947b6bb36f729a3a049d42b05d0b523585b6b8d28bf36997c92a8f327e05"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bavanchun/AriadShift/releases/download/v0.4.0/ariad-cli-x86_64-unknown-linux-musl.tar.xz"
      sha256 "c94cb70f9d1cef81f02cf37379ecdd8ea5ffdd1043890084fbf9c33b3d8dd060"
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
