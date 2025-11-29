class EnvelopeCli < Formula
  desc "Terminal-based zero-based budgeting application"
  homepage "https://github.com/KayleeBeyene/EnvelopeCLI"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/KayleeBeyene/EnvelopeCLI/releases/download/v0.2.1/envelope-cli-aarch64-apple-darwin.tar.xz"
      sha256 "2db298656a312235af0bbe0d4fbe4e43fb976fcf77f094a53e9824ac0e2ffca8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/KayleeBeyene/EnvelopeCLI/releases/download/v0.2.1/envelope-cli-x86_64-apple-darwin.tar.xz"
      sha256 "69e415548475ef5a5d3c4608d1b53b652e9d68a557ba8d558466629f951ddd37"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/KayleeBeyene/EnvelopeCLI/releases/download/v0.2.1/envelope-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f8317b62f2560a6484a745554f0df1e521d3bb20d5a5ec667bcbd33a72244d88"
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
