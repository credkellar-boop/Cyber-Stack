use aya::maps::RingBuf;
use aya::Bpf;
use std::sync::Arc;
use tokio::task;
use log::{info, error};

pub async fn monitor_ring_buffer(bpf: Arc<Bpf>) -> Result<(), anyhow::Error> {
    info!("Attaching to eBPF Ring Buffer for high-speed telemetry ingestion...");

    // Locate the ring buffer map defined in the kernel C code
    let mut ring_buf = RingBuf::try_from(bpf.map_mut("telemetry_ring")?)?;

    task::spawn(async move {
        loop {
            // Asynchronously wait for new data from the kernel
            if let Some(item) = ring_buf.next() {
                let data = item.as_ref();
                // Pass the raw byte slice to the telemetry processor
                if let Err(e) = crate::telemetry::process_bpf_telemetry(data).await {
                    error!("Failed to process telemetry: {}", e);
                }
            }
        }
    });

    Ok(())
}
