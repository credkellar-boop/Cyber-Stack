#!/usr/bin/env python3
import torch
from transformers import AutoModelForCausalLM, AutoTokenizer
from peft import PeftModel
import os

def merge_and_save(base_model_path, adapter_path, output_path):
    print(f"[*] Loading base Llama 3 model from {base_model_path}...")
    
    base_model = AutoModelForCausalLM.from_pretrained(
        base_model_path,
        torch_dtype=torch.float16,
        device_map="auto"
    )
    tokenizer = AutoTokenizer.from_pretrained(base_model_path)

    print(f"[*] Applying LoRA weights from {adapter_path}...")
    model = PeftModel.from_pretrained(base_model, adapter_path)
    
    print("[*] Merging weights for inference performance...")
    model = model.merge_and_unload()

    print(f"[+] Saving unified model to {output_path}...")
    model.save_pretrained(output_path)
    tokenizer.save_pretrained(output_path)
    print("[+] Merge complete. Ready for vLLM deployment.")

if __name__ == "__main__":
    # Define paths relative to the ai_models directory
    base_dir = os.path.dirname(__file__)
    merge_and_save(
        os.path.join(base_dir, "weights"),
        os.path.join(base_dir, "lora_adapters", "cyber_intel_v1"),
        os.path.join(base_dir, "merged_weights")
    )
