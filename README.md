# Cyber-Stack Monorepo

An ultra-high-performance framework combining kernel-level networking, asynchronous I/O, offensive auditing infrastructure, and local generative AI orchestration.

## Architecture Directory
* **red_team_infrastructure/**: Core auditing wrappers, tamper scripts, and YARA signatures.
* **ai_models/**: Local Llama 3 inference configurations and acceleration pipelines.
* **low_level_perf/**: DPDK user-space networking, `io_uring` async engine, and eBPF/XDP hooks.
* **core_systems/**: Core business logic, memory-safe abstractions, and fuzzing harnesses.

## Prerequisites
* Linux Kernel >= 5.15 (Required for advanced `io_uring` and XDP features)
* LLVM/Clang (eBPF compilation)
* Rust (Cargo workspace tooling)
* Zig Compiler (v0.11+ or newer)
* CMake & CUDA Toolkit (For GPU acceleration layers)

## Building the Workspace
To build all subsystems, run the specific orchestration targets within the `build_scripts/` directory or trigger language-specific toolchains individually.

cyber-stack/
├── red_team_infrastructure/    # 🔴 CATEGORY: Red Team Infrastructure
│   ├── sqlmap/                 # └─ Integrations for automated database takeover
│   ├── tamper_scripts/         # └─ Custom scripts for WAF bypass & payload obfuscation
│   └── yara/                   # └─ Pattern matching rules for malware & memory scanning
│
├── ai_models/                  # 🟣 CATEGORY: AI 
│   └── llama_3/                # └─ Local Llama 3 weights, tokenizers, and prompt templates
│
├── low_level_perf/             # 🟢/🔵/🟠 CATEGORY: Low-Level Perf
│   ├── dpdk_supported/         # └─ User-space network packet processing bypass
│   ├── io_uring/               # └─ High-performance, asynchronous disk & network I/O
│   └── kernel_hooks/           
│       ├── ebpf/               #    └─ Safe, in-kernel observability and tracing
│       └── xdp/                #    └─ eXpress Data Path for bare-metal packet dropping
│
├── core_systems/               # (The foundational glue from the previous steps)
│   ├── rust_orchestrator/      # Memory-safe backend tying the modules together
│   ├── cuda_acceleration/      # GPU offloading for Llama 3
│   └── security_fuzzing/       # AFL++, syzkaller, and libFuzzer targets
│
├── deploy/                     # Deployment configurations
├── build_scripts/              # Unified compilation pipelines
└── README.md                   
