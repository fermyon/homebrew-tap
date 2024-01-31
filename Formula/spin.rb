class Spin < Formula
  desc "Open-source tool for building and running serverless WebAssembly applications"
  homepage "https://developer.fermyon.com/spin"
  version "2.2.0"

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/fermyon/spin/releases/download/v#{version}/spin-v#{version}-macos-amd64.tar.gz"
    sha256 "6fdfd5725c91487d8b95d8df72d44274748593f3565e0c9ca5e53df8143e8958"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/fermyon/spin/releases/download/v#{version}/spin-v#{version}-macos-aarch64.tar.gz"
    sha256 "569634765e7a289bb0e68dbaace999da605accbcd54c5f048dedb0c64eee3a36"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/fermyon/spin/releases/download/v#{version}/spin-v#{version}-linux-amd64.tar.gz"
    sha256 "dae821ee0a688aa31319ef503d3b9726777e5399ab4972102b54f0b9cb8fe2cf"
  end

  if OS.linux? && Hardware::CPU.arm?
    url "https://github.com/fermyon/spin/releases/download/v#{version}/spin-v#{version}-linux-aarch64.tar.gz"
    sha256 "7b6d2dc9a1b350603e527ec03720020034eac523a9695a09fc448759ab5dd04d"
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
    assert shell_output("#{bin}/spin --version").start_with?("spin #{version}")
  end
end
