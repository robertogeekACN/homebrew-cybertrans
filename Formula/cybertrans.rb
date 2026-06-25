class Cybertrans < Formula
  desc "Batch-transcode videos to web-optimised H.264/H.265 in-place with cyberpunk UI"
  homepage "https://github.com/robertogeekACN/CyberTranscoder"
  url "https://raw.githubusercontent.com/robertogeekACN/CyberTranscoder/dist/cybertrans.pyz"
  sha256 "d4ffef2da37bc639352f37578826708b6800810e605b7a131cc3472b25f5b82b"
  version "1.2.1"
  license "MIT"

  resource "finder_setup" do
    url "https://raw.githubusercontent.com/robertogeekACN/CyberTranscoder/dist/cybertrans-finder-setup"
    sha256 "3e4593271af72c4fd6858a738e586ef0d4a2616c24295f1a83a74ab06de63723"
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
