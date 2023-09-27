class Spin < Formula
  desc "Open-source tool for building and running serverless WebAssembly applications"
  homepage "https://developer.fermyon.com/spin"
  version "1.5.1"

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/fermyon/spin/releases/download/v1.5.0/spin-v1.5.0-macos-amd64.tar.gz"
    sha256 "f19668ba1327edf0b2adac84796efc3ab0f86bda8fc072721ee1e2f741672174"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/fermyon/spin/releases/download/v1.5.0/spin-v1.5.0-macos-aarch64.tar.gz"
    sha256 "1e397885a5a3219c67d46909ead26a42fe21bcac4abf58e3845e749071e3489a"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/fermyon/spin/releases/download/v1.5.0/spin-v1.5.0-linux-amd64.tar.gz"
    sha256 "31941a09c870f9bb3e74a068e1573bf7efb60bffdd3c555a1a0fd75d9fa1b217"
  end

  if OS.linux? && Hardware::CPU.arm?
    url "https://github.com/fermyon/spin/releases/download/v1.5.0/spin-v1.5.0-linux-aarch64.tar.gz"
    sha256 "d0c9a9903279f60fedb6425463c872066507923a1845cdead256d65705515b11"
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
