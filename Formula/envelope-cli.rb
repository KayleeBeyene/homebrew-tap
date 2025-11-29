class EnvelopeCli < Formula
  desc "Terminal-based zero-based budgeting application"
  homepage "https://github.com/KayleeBeyene/EnvelopeCLI"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/KayleeBeyene/EnvelopeCLI/releases/download/v0.1.0/envelope-cli-aarch64-apple-darwin.tar.xz"
      sha256 "298ab9bbc582870809f18f07e5253b956e3fe683cd32351712f0162436d11433"
    end
    if Hardware::CPU.intel?
      url "https://github.com/KayleeBeyene/EnvelopeCLI/releases/download/v0.1.0/envelope-cli-x86_64-apple-darwin.tar.xz"
      sha256 "bb5997205ef3d1b95024aa2a7fc88852b3a19aee429af563c6e98a7eed8d9dac"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/KayleeBeyene/EnvelopeCLI/releases/download/v0.1.0/envelope-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1553c2898502b90fd9cf7d852c6026c5ff0a17becac7b106465d670dabc7c5c7"
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
