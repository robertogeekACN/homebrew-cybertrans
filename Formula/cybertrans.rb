class Cybertrans < Formula
  desc "Batch-transcode videos to web-optimised H.264/H.265 in-place with cyberpunk UI"
  homepage "https://github.com/robertogeekACN/CyberTranscoder"
  url "https://raw.githubusercontent.com/robertogeekACN/CyberTranscoder/dist/cybertrans.pyz"
  sha256 "22b0a4dc995dba8fb0d40545c7b5ea194c8f5447f39ec233d55bebfa09a6aa7f"
  version "1.2.0"
  license "MIT"

  resource "finder_setup" do
    url "https://raw.githubusercontent.com/robertogeekACN/CyberTranscoder/dist/cybertrans-finder-setup"
    sha256 "10c64ff0a067ac973f4fc6cfef37e26c60d9c9caa71a747dde0cd8edf1454c65"
  end

  depends_on "ffmpeg"

  def install
    libexec.install "cybertrans.pyz"
    (bin/"cybertrans").write <<~SH
      #!/bin/bash
      exec python3 "#{libexec}/cybertrans.pyz" "$@"
    SH
    resource("finder_setup").stage do
      bin.install "cybertrans-finder-setup"
    end
  end

  def caveats
    <<~EOS
      To add Finder Quick Actions (right-click on a file/folder → Transcode now):
        cybertrans-finder-setup

      Then enable in:
        System Settings → Privacy & Security → Extensions → Finder
        (tick each "CyberTrans" entry)

      To remove:
        cybertrans-finder-setup --uninstall
    EOS
  end

  test do
    system "python3", "-c",
      "import zipimport; zipimport.zipimporter('#{libexec}/cybertrans.pyz')"
  end
end
