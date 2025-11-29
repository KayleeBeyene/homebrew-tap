class EnvelopeCli < Formula
  desc "Terminal-based zero-based budgeting application"
  homepage "https://github.com/KayleeBeyene/EnvelopeCLI"
  version "0.2.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/KayleeBeyene/EnvelopeCLI/releases/download/v0.2.5/envelope-cli-aarch64-apple-darwin.tar.xz"
      sha256 "a8ff93a8a4072832b1d2f345dabce64e7b61129cef0d98aa6d234fe3c663d7dd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/KayleeBeyene/EnvelopeCLI/releases/download/v0.2.5/envelope-cli-x86_64-apple-darwin.tar.xz"
      sha256 "bceb5d21c183f16578b6a0063809b839f5f0e8b28bb3130fc5faa3f93d091744"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/KayleeBeyene/EnvelopeCLI/releases/download/v0.2.5/envelope-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3a834e30b1a8625faf5a6eb297990a518ce281d48ae96e905e179b6f38be4269"
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
