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

## Troubleshooting

If `nexperf open` shows the fallback page or does not open the installed dashboard, make sure Homebrew's binary is the one your shell finds first:

```sh
which -a nexperf
```

The Homebrew binary should appear before any development build, for example:

```txt
/opt/homebrew/bin/nexperf
```

You can also run the installed binary directly:

```sh
/opt/homebrew/opt/nexperf/bin/nexperf open
```
