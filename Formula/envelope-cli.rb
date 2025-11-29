class EnvelopeCli < Formula
  desc "Terminal-based zero-based budgeting application"
  homepage "https://github.com/KayleeBeyene/EnvelopeCLI"
  version "0.2.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/KayleeBeyene/EnvelopeCLI/releases/download/v0.2.4/envelope-cli-aarch64-apple-darwin.tar.xz"
      sha256 "0397ebf52e31de8eb125ac3240ed4e049dd8098e1e794df303aeecedeb6e095a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/KayleeBeyene/EnvelopeCLI/releases/download/v0.2.4/envelope-cli-x86_64-apple-darwin.tar.xz"
      sha256 "e5d48db714f9a1f2e716493663a77a9b17cfb90f495e7ed4d359df986ea88c40"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/KayleeBeyene/EnvelopeCLI/releases/download/v0.2.4/envelope-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "391d6675148b02534f52d3c4e3a487d15c0df6409ccd46c63999460011057580"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {}
  }

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
      bin.install "envelope"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "envelope"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "envelope"
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
