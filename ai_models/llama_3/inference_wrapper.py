import os
from vllm import LLM, SamplingParams
from typing import List

class CyberStackInferenceEngine:
    def __init__(self, config_path: str):
        # Instantiate the localized model deployment context
        self.llm = LLM(
            model="meta-llama/Meta-Llama-3-8B-Instruct",
            tensor_parallel_size=1,
            gpu_memory_utilization=0.85,
            max_model_len=4096
        )
        # Enforce highly rigid decoding parameters to maintain consistency
        self.sampling_params = SamplingParams(
            temperature=0.2,
            top_p=0.9,
            max_tokens=512,
            stop=["<|eot_id|>"]
        )

    def generate_response(self, prompt: str) -> List[str]:
        # Wrap prompt configuration inside explicit system instructions
        system_prompt = f"<|begin_of_text|><|start_header_id|>system<|end_header_id|>\n" \
                        f"Analyze the following operational context under strict schema rules.<|eot_id|>" \
                        f"<|start_header_id|>user<|end_header_id|>\n{prompt}<|eot_id|>" \
                        f"<|start_header_id|>assistant<|end_header_id|>\n"
        
        outputs = self.llm.generate([system_prompt], self.sampling_params)
        return [output.outputs[0].text for output in outputs]
