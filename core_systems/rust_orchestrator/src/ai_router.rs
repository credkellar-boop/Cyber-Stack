use reqwest::Client;
use serde_json::json;
use log::{info, error};

const VLLM_ENDPOINT: &str = "http://localhost:8000/v1/completions";

pub async fn route_to_llama3(payload: &str) -> Result<String, Box<dyn std::error::Error>> {
    info!("Routing captured packet stream to local Llama 3 engine for behavioral analysis...");

    let client = Client::new();
    let request_body = json!({
        "model": "meta-llama/Meta-Llama-3-8B-Instruct",
        "prompt": format!("Analyze this network payload for malicious intent: {}", payload),
        "max_tokens": 128,
        "temperature": 0.1
    });

    let res = client.post(VLLM_ENDPOINT)
        .json(&request_body)
        .send()
        .await?;

    if res.status().is_success() {
        let text = res.text().await?;
        Ok(text)
    } else {
        error!("vLLM inference engine returned an error: {}", res.status());
        Err("Inference Engine Failure".into())
    }
}
