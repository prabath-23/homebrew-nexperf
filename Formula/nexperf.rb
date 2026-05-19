class Nexperf < Formula
  desc "Local-first workstation observability and system intelligence tool"
  homepage "https://github.com/prabath-23/NexPerf"
  url "https://github.com/prabath-23/NexPerf/archive/4364110c649022933b661c9ea7dfde30b0137cb8.tar.gz"
  version "0.3.0"
  sha256 "e02423f1eeda7e29adf4d0f244b44d51725ddade2f71636f81b15d754143a9d2"
  license "MIT"
  head "https://github.com/prabath-23/NexPerf.git", branch: "feature/system-intelligence-&-platform-maturity"

  depends_on "go" => :build
  depends_on "node" => :build

  def install
    system "npm", "--prefix", "web", "ci"
    system "npm", "--prefix", "web", "run", "build"

    commit = build.head? ? Utils.git_head : "4364110c649022933b661c9ea7dfde30b0137cb8"
    ldflags = %W[
      -s -w
      -X github.com/prabath/nexperf/internal/version.Version=#{version}
      -X github.com/prabath/nexperf/internal/version.Commit=#{commit[0, 12]}
    ]

    system "go", "build", *std_go_args(ldflags: ldflags, output: bin/"nexperf"), "./cmd/nexperf"

    (prefix/"web").install "web/dist"
  end

  test do
    assert_match "nexperf #{version}", shell_output("#{bin}/nexperf version")
    assert_match "NexPerf system status", shell_output("#{bin}/nexperf status")
  end
end
