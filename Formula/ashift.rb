class Ashift < Formula
  desc "Command-line interface and Model Context Protocol (MCP) server for AriadShift (ashift)"
  homepage "https://github.com/bavanchun/AriadShift"
  version "0.6.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/bavanchun/AriadShift/releases/download/v0.6.0/ariad-cli-aarch64-apple-darwin.tar.xz"
      sha256 "3fa8a03ac4290ef48492a61d378b5ee58b4585b505aac4be1b730e21e08cff00"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bavanchun/AriadShift/releases/download/v0.6.0/ariad-cli-x86_64-apple-darwin.tar.xz"
      sha256 "2010cef0ca7961fc748ca6b3cf9f274a02815ff2b8d147eac1b546e4adba0bd8"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/bavanchun/AriadShift/releases/download/v0.6.0/ariad-cli-aarch64-unknown-linux-musl.tar.xz"
      sha256 "f4c055b250cdfd92e0bcd73d0e8744bcd9ea1ba2104410758ba26bccdea6c1ed"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bavanchun/AriadShift/releases/download/v0.6.0/ariad-cli-x86_64-unknown-linux-musl.tar.xz"
      sha256 "228053f514e4914b1a72b5b36f004c5cf8c82d7b9fe752583c5cf6fdbfbf6df3"
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
