class Spin < Formula
  desc "Open-source tool for building and running serverless WebAssembly applications"
  homepage "https://developer.fermyon.com/spin"
  version "2.7.0"

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/fermyon/spin/releases/download/v#{version}/spin-v#{version}-macos-amd64.tar.gz"
    sha256 "7df44314dab98ffd7b0691fb02cfabe5aa63e02d0d0343f7801da198e5e3a9de"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/fermyon/spin/releases/download/v#{version}/spin-v#{version}-macos-aarch64.tar.gz"
    sha256 "fddcf6ae415c60305f9f7be62d0eed35a164d79afbdff492a74b2080767043dd"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/fermyon/spin/releases/download/v#{version}/spin-v#{version}-linux-amd64.tar.gz"
    sha256 "9d49b1adebd042ed8e02e354390ee07bf52fedbf0d517f0411bbb16a6c609e90"
  end

  if OS.linux? && Hardware::CPU.arm?
    url "https://github.com/fermyon/spin/releases/download/v#{version}/spin-v#{version}-linux-aarch64.tar.gz"
    sha256 "30a56088611b7a81b5cd0bb020c014a98897e3a35f0b10873123e2125a9d9742"
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
    system "#{bin}/spin", "plugins", "install", "cloud", "--yes"
  end

  test do
    assert shell_output("#{bin}/spin --version").start_with?("spin #{version}")
  end
end
