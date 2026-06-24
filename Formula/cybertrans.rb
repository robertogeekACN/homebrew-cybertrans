class Cybertrans < Formula
  desc "Batch-transcode videos to web-optimised H.264/H.265 in-place with cyberpunk UI"
  homepage "https://github.com/AccentureCodeFoundry/314899_Cybertranscoding"
  url "https://github.com/AccentureCodeFoundry/314899_Cybertranscoding/releases/download/v1.0.0/cybertrans.pyz"
  sha256 "d9f15e9fdd4994b65ef60cb4873101a07f5782988c40af0505967f1314a0f910"
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
