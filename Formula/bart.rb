class Bart < Formula
  desc "Micro-CMS for WebAssembly and Spin"
  homepage "https://developer.fermyon.com/bartholomew"
  version "0.9.0"

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/fermyon/bartholomew/releases/download/v0.9.0/bart-v0.9.0-macos-amd64.tar.gz"
    sha256 "0f4e5a3844b6d5ef4b7d33a50c69ddba002874da15d2821eea5736216c6ec0d9"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/fermyon/bartholomew/releases/download/v0.9.0/bart-v0.9.0-macos-aarch64.tar.gz"
    sha256 "85f30737b2eabd5426398b4edaf72d3454fed992d64c7dbeb2c630040588918b"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/fermyon/bartholomew/releases/download/v0.9.0/bart-v0.9.0-linux-amd64.tar.gz"
    sha256 "6a95803c3c62f67efccbaed1ebf506fdbe458f22e31fad66622b434265539d64"
  end

  if OS.linux? && Hardware::CPU.arm?
    url "https://github.com/fermyon/bartholomew/releases/download/v0.9.0/bart-v0.9.0-linux-aarch64.tar.gz"
    sha256 "5b031b864e03883ddb740aab8fd4ffaf306d043ba86f90bc5c123cef1ea7f006"
  end

  def install
    bin.install "bart"
  end

  test do
    assert shell_output("#{bin}/bart --version").start_with?("bart 0.9.0")
  end
end