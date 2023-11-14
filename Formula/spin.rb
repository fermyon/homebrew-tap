class Spin < Formula
  desc "Open-source tool for building and running serverless WebAssembly applications"
  homepage "https://developer.fermyon.com/spin"
  version "2.0.1"

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/fermyon/spin/releases/download/v2.0.1/spin-v2.0.1-macos-amd64.tar.gz"
    sha256 "00ddfa87cdbbb2089cf87300f581c1e1a7e8fa02a560dbb89145e89cbc552675"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/fermyon/spin/releases/download/v2.0.1/spin-v2.0.1-macos-aarch64.tar.gz"
    sha256 "65bf7caf63fe9fd6b23c96dad8d6d71dd6c8028cf1684b6ff4b895aa4001bd29"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/fermyon/spin/releases/download/v2.0.1/spin-v2.0.1-linux-amd64.tar.gz"
    sha256 "686bb12b9244ed33bf54a53e62303879036632b476ad09a728172b260f26c8e7"
  end

  if OS.linux? && Hardware::CPU.arm?
    url "https://github.com/fermyon/spin/releases/download/v2.0.1/spin-v2.0.1-linux-aarch64.tar.gz"
    sha256 "e2ca780a1f914839fb7448db925c0376236fe2aea60173ead3201d4c2a0b89f1"
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
    assert_match "spin 1.5.1 (8d4334e 2023-09-26)", shell_output("#{bin}/spin --version")
  end
end