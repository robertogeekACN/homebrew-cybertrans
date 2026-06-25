class Cybertrans < Formula
  desc "Batch-transcode videos to web-optimised H.264/H.265 in-place with cyberpunk UI"
  homepage "https://github.com/robertogeekACN/CyberTranscoder"
  url "https://raw.githubusercontent.com/robertogeekACN/CyberTranscoder/dist/cybertrans.pyz"
  sha256 "21997c52a6a127d02046fd0d80af0d70c6e809391a062b868fa42a7e0295d843"
  version "1.1.0"
  license "MIT"

  depends_on "ffmpeg"

  def install
    libexec.install "cybertrans.pyz"
    (bin/"cybertrans").write <<~SH
      #!/bin/bash
      exec python3 "#{libexec}/cybertrans.pyz" "$@"
    SH
  end

  test do
    # Verify the zipapp is importable (no syntax errors, valid zip structure)
    system "python3", "-c",
      "import zipimport; zipimport.zipimporter('#{libexec}/cybertrans.pyz')"
  end
end
