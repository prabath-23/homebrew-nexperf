# homebrew-nexperf

Homebrew tap for [NexPerf](https://github.com/prabath-23/NexPerf), a local-first workstation observability and system intelligence tool.

## Install

```sh
brew tap prabath-23/nexperf
brew install nexperf
```

## Use

```sh
nexperf start
nexperf open
nexperf status
nexperf stop
```

The dashboard runs locally at:

```txt
http://127.0.0.1:8756/nexperf
```

## HEAD build

```sh
brew install --HEAD prabath-23/nexperf/nexperf
```
