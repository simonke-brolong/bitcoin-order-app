#!/bin/bash
set -eu

report_dir="$(mktemp -d)"
chmod a+wx "$report_dir"

docker run --rm -v "$report_dir:/zap/wrk:rw" \
  ghcr.io/zaproxy/zaproxy:stable \
  zap-baseline.py \
  -t "https://simonke-brolong.github.io/bitcoin-order-app/" \
  -r zap_baseline_report.html -I

test -s "$report_dir/zap_baseline_report.html"
cp "$report_dir/zap_baseline_report.html" ./zap_baseline_report.html