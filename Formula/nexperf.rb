class Nexperf < Formula
  desc "Local-first workstation observability and system intelligence tool"
  homepage "https://github.com/prabath-23/NexPerf"
  url "https://github.com/prabath-23/NexPerf/archive/41b7bfb2c9c97eaacf29be165be259d8c2adc032.tar.gz"
  version "0.3.0"
  sha256 "426d891fc3852f7cd145e83120ca6250e66b486207019c51c906f3226fa1d711"
  license "MIT"
  head "https://github.com/prabath-23/NexPerf.git", branch: "feature/system-intelligence-&-platform-maturity"

  depends_on "go" => :build
  depends_on "node" => :build

  def install
    system "npm", "--prefix", "web", "ci"
    system "npm", "--prefix", "web", "run", "build"

    commit = build.head? ? Utils.git_head : "41b7bfb2c9c97eaacf29be165be259d8c2adc032"
    ldflags = %W[
      -s -w
      -X github.com/prabath/nexperf/internal/version.Version=#{version}
      -X github.com/prabath/nexperf/internal/version.Commit=#{commit[0, 12]}
    ]

    system "go", "build", *std_go_args(ldflags: ldflags, output: libexec/"bin/nexperf"), "./cmd/nexperf"

    (libexec/"web").install "web/dist"
    bin.write_exec_script libexec/"bin/nexperf"
  end

  test do
    assert_match "nexperf #{version}", shell_output("#{bin}/nexperf version")
    assert_match "NexPerf system status", shell_output("#{bin}/nexperf status")

    port = free_port
    pid = spawn bin/"nexperf", "--port", port.to_s, "serve"
    begin
      sleep 2
      assert_match '<div id="app"></div>', shell_output("curl -fsS http://127.0.0.1:#{port}/nexperf")
    ensure
      Process.kill("TERM", pid)
      Process.wait(pid)
    end
  end
end
