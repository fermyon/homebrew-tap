class Bart < Formula
  desc "The Micro-CMS for WebAssembly and Spin"
  homepage "https://developer.fermyon.com/bartholomew"
  version "0.8.0"

  # TODO: replace the 'url' values with the actual release binaries; update 'sha256' values

  # if OS.mac? && Hardware::CPU.intel?
  #   url "https://github.com/fermyon/bartholomew/releases/download/v0.8.0/bart-v0.8.0-macos-amd64.tar.gz"
  #   sha256 "989bd9e6def00b332038681697b388ea460a68b0ed5bf04bdebfce32e6bd0357"
  # end

  # if OS.mac? && Hardware::CPU.arm?
  #   url "https://github.com/fermyon/bartholomew/releases/download/v0.8.0/bart-v0.8.0-macos-aarch64.tar.gz"
  #   sha256 "48437366bc10c29e6fa0d917646c983d81cc0b1562cc5f37cda66f116a1247a0"
  # end

  # if OS.linux? && Hardware::CPU.intel?
  #   url "https://github.com/fermyon/bartholomew/releases/download/v0.8.0/bart-v0.8.0-linux-amd64.tar.gz"
  #   sha256 "6c339d17e15eb2131db46c150a186bba3f8348d572fa9db8c9d83666e6bce559"
  # end

  # if OS.linux? && Hardware::CPU.arm?
  #   url "https://github.com/fermyon/bartholomew/releases/download/v0.8.0/bart-v0.8.0-linux-aarch64.tar.gz"
  #   sha256 "1d433c3cbdce020674d90eb5f7f43725e63595ad7cf3a95d4f13bc55b3f40b5a"
  # end

  def install
    bin.install "bart"
  end

  test do
    # system "#{bin}/bart", "--version"
    # TODO: test & confirm this is proper syntax, then adjust spin.rb too
    assert_match "bart 0.8.0", shell_output("#{bin}/bart --version")
  end
end