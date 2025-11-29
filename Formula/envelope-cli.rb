class EnvelopeCli < Formula
  desc "Terminal-based zero-based budgeting application"
  homepage "https://github.com/KayleeBeyene/EnvelopeCLI"
  version "0.1.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/KayleeBeyene/EnvelopeCLI/releases/download/v0.1.3/envelope-cli-aarch64-apple-darwin.tar.xz"
      sha256 "a2d26513ac07137900e8b674364aea0f5fa3003d1e240cf8db666a0ab12738f1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/KayleeBeyene/EnvelopeCLI/releases/download/v0.1.3/envelope-cli-x86_64-apple-darwin.tar.xz"
      sha256 "411f83b6f5e4eee86e05793d3f332150baadb5459f2b318981229ed469b84923"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/KayleeBeyene/EnvelopeCLI/releases/download/v0.1.3/envelope-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9c72856dc199a9c6d7518adcdd8040b9585aada502e2463e86dc296fcf28f141"
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
