class Spin < Formula
  desc "Open-source tool for building and running serverless WebAssembly applications"
  homepage "https://developer.fermyon.com/spin"
  version "1.5.0"

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/fermyon/spin/releases/download/v1.5.0/spin-v1.5.0-macos-amd64.tar.gz"
    sha256 "989bd9e6def00b332038681697b388ea460a68b0ed5bf04bdebfce32e6bd0357"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/fermyon/spin/releases/download/v1.5.0/spin-v1.5.0-macos-aarch64.tar.gz"
    sha256 "48437366bc10c29e6fa0d917646c983d81cc0b1562cc5f37cda66f116a1247a0"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/fermyon/spin/releases/download/v1.5.0/spin-v1.5.0-linux-amd64.tar.gz"
    sha256 "6c339d17e15eb2131db46c150a186bba3f8348d572fa9db8c9d83666e6bce559"
  end

  if OS.linux? && Hardware::CPU.arm?
    url "https://github.com/fermyon/spin/releases/download/v1.5.0/spin-v1.5.0-linux-aarch64.tar.gz"
    sha256 "1d433c3cbdce020674d90eb5f7f43725e63595ad7cf3a95d4f13bc55b3f40b5a"
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
