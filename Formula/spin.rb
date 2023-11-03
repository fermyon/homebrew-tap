class Spin < Formula
  desc "Open-source tool for building and running serverless WebAssembly applications"
  homepage "https://developer.fermyon.com/spin"
  version "2.0.0"

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/fermyon/spin/releases/download/v2.0.0/spin-v2.0.0-macos-amd64.tar.gz"
    sha256 "77a3cc3a41fa80d4adbd677f0262fe9628bce0437cbf67c2f58e0850fc211c8e"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/fermyon/spin/releases/download/v2.0.0/spin-v2.0.0-macos-aarch64.tar.gz"
    sha256 "61ece934e52f0a86ebf35b2eedc43a52b4156d10d349d36cba3300d2065d144d"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/fermyon/spin/releases/download/v2.0.0/spin-v2.0.0-linux-amd64.tar.gz"
    sha256 "ec9a335663c6af3dba34860ba5a0f99916f06f98ad504fae800b329eb41c7595"
  end

  if OS.linux? && Hardware::CPU.arm?
    url "https://github.com/fermyon/spin/releases/download/v2.0.0/spin-v2.0.0-linux-aarch64.tar.gz"
    sha256 "520e8e9ff2602629a304d3854147442c0881eef525850f2eaa2521fddf1b11cb"
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
