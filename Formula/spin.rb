class Spin < Formula
  desc "Open-source tool for building and running serverless WebAssembly applications"
  homepage "https://developer.fermyon.com/spin"
  version "2.3.1"

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/fermyon/spin/releases/download/v#{version}/spin-v#{version}-macos-amd64.tar.gz"
    sha256 "f259ae2a0323725c9ff4177696308b2a3dc0f38a589cd2dd56b43f6b538732a3"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/fermyon/spin/releases/download/v#{version}/spin-v#{version}-macos-aarch64.tar.gz"
    sha256 "b61d18fae6606e701aefd750767ccdf0a9283eabd92a4dc9d695b9fc439d80e6"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/fermyon/spin/releases/download/v#{version}/spin-v#{version}-linux-amd64.tar.gz"
    sha256 "165e3fe450e2472fd951881217d244babfcfd4d3039f12325a310a2344749867"
  end

  if OS.linux? && Hardware::CPU.arm?
    url "https://github.com/fermyon/spin/releases/download/v#{version}/spin-v#{version}-linux-aarch64.tar.gz"
    sha256 "5eab2c51184acce21217b417b882122ff7cff939a2b712e107694d509946d8ae"
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
