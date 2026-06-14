#!/bin/bash
set -e

echo "==> Building Rust Orchestrator..."
cargo build --package rust_orchestrator
