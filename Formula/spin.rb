class Spin < Formula
  desc "Open-source tool for building and running serverless WebAssembly applications"
  homepage "https://developer.fermyon.com/spin"
  version "1.4.2"

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/fermyon/spin/releases/download/v1.4.2/spin-v1.4.2-macos-amd64.tar.gz"
    sha256 "4d1c6eb6ef7add631ca80206cc5b6aa9d9ad2bc9e4d79d111440db10e82f09f6"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/fermyon/spin/releases/download/v1.4.2/spin-v1.4.2-macos-aarch64.tar.gz"
    sha256 "e519fac62ce3c830a83cac04ef0a409d155837c4334702a49951ceda258ae4ed"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/fermyon/spin/releases/download/v1.4.2/spin-v1.4.2-linux-amd64.tar.gz"
    sha256 "3298cb418aed5fd88b646b0bc6d1b2ceba171775dc323d76722c7010a11e0699"
  end

  if OS.linux? && Hardware::CPU.arm?
    url "https://github.com/fermyon/spin/releases/download/v1.4.2/spin-v1.4.2-linux-aarch64.tar.gz"
    sha256 "32cb6adac9a50162f5400741d5a3624c26f2ce7bc71fe63caad207a633a1a6af"
  end

  def install
    bin.install "spin"
  end

  def post_install
    # Install default templates and plugins for language tooling and deploying apps to the cloud.
    # Templates and plugins are installed into `pkgetc/"templates"` and `pkgetc/"plugins"`.
    system "#{bin}/spin", "templates", "install", "--git", "https://github.com/fermyon/spin", "--upgrade"
    system "#{bin}/spin", "templates", "install", "--git", "https://github.com/fermyon/spin-python-sdk", "--upgrade"
    system "#{bin}/spin", "templates", "install", "--git", "https://github.com/fermyon/spin-js-sdk", "--upgrade"
    system "#{bin}/spin", "plugins", "update"
    system "#{bin}/spin", "plugins", "install", "js2wasm", "--yes"
    system "#{bin}/spin", "plugins", "install", "py2wasm", "--yes"
    system "#{bin}/spin", "plugins", "install", "cloud", "--yes"
  end

  test do
    system "#{bin}/spin", "--version"
  end
end
