#!/usr/bin/env bash
set -euo pipefail

echo "[*] Compiling eBPF/XDP Object Files..."

# Clang compilation flags specific to eBPF target architecture
CLANG_FLAGS="-O2 -g -Wall -target bpf -c"

# Compile the pass-through XDP hook
clang $CLANG_FLAGS xdp_pass.c -o xdp_pass.o

echo "[+] xdp_pass.o successfully compiled. Ready for Aya user-space loader."
