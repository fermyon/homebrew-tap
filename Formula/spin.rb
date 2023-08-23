class Spin < Formula
  desc "Open-source tool for building and running serverless WebAssembly applications"
  homepage "https://spin.fermyon.dev/"
  version "1.4.1"

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/fermyon/spin/releases/download/v1.4.1/spin-v1.4.1-macos-amd64.tar.gz"
    sha256 "d42abb4dc79affb5cbd6a0f4e2bc2837675dca23aed9587a85f4d86672ec7f6f"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/fermyon/spin/releases/download/v1.4.1/spin-v1.4.1-macos-aarch64.tar.gz"
    sha256 "98c3130468bb3e40b0cf6c94d3a746562fe2b6323d04e57cbfe3f753a8c5ccfe"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/fermyon/spin/releases/download/v1.4.1/spin-v1.4.1-linux-amd64.tar.gz"
    sha256 "199881bf6c676d698e8fc910f7dc37aaa557d5db5ad2e080f65c48bac5fa786a"
  end

  if OS.linux? && Hardware::CPU.arm?
    url "https://github.com/fermyon/spin/releases/download/v1.4.1/spin-v1.4.1-linux-aarch64.tar.gz"
    sha256 "2ecff49db739ec8d3c1ee6409bedfcfe8a9b67aec3867bc4349a2c2d764291ce"
  end

  conflicts_with "spin"

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
    # Set permissions for local plugins repository
    chmod_R(0755, etc/"fermyon-spin/plugins")
  end

  test do
    system "#{bin}/spin", "--version"
  end
end
