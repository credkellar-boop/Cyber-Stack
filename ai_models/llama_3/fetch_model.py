#!/usr/bin/env python3
import os
from huggingface_hub import snapshot_download

def download_llama_3():
    # Requires HF_TOKEN environment variable to be set with access permissions
    token = os.environ.get("HF_TOKEN")
    if not token:
        print("[-] HF_TOKEN environment variable not found. Cannot fetch gated model.")
        return

    model_id = "meta-llama/Meta-Llama-3-8B-Instruct"
    save_dir = os.path.join(os.path.dirname(__file__), "weights")

    print(f"[*] Downloading {model_id} to {save_dir}...")
    
    # Download weights focusing strictly on safetensors for security
    snapshot_download(
        repo_id=model_id,
        local_dir=save_dir,
        token=token,
        allow_patterns=["*.safetensors", "*.json", "*.model"],
        ignore_patterns=["*.bin", "*.pt"] # Ignore insecure pickle formats
    )
    print("[+] Model download complete.")

if __name__ == "__main__":
    download_llama_3()
