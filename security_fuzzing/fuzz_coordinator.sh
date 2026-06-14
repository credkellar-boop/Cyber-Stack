#!/usr/bin/env bash
set -euo pipefail

echo "[*] Initializing Fuzzing Coordinator Pipelines..."

# Create runtime directories for fuzzer state retention
mkdir -p inputs outputs

# Seed an abstract input case if empty
if [ ! -f inputs/seed.txt ]; then
    echo "CYB\xFF\x00\x00" > inputs/seed.txt
fi

# Orchestrate execution profiles depending on active targets passed
TARGET="${1:-libfuzzer}"

if [ "$TARGET" == "libfuzzer" ]; then
    echo "[+] Launching in-process libFuzzer pipeline target..."
    ./core_systems/build/security_fuzzing/libfuzzer_targets/parse_target -max_len=1024 inputs/
elif [ "$TARGET" == "afl" ]; then
    echo "[+] Launching evolutionary path tracking loop via AFL++..."
    afl-fuzz -i inputs/ -o outputs/ -- ./core_systems/build/security_fuzzing/afl_harnesses/harness_io
else
    echo "[-] Unrecognized target mode chosen."
    exit 1
fi
