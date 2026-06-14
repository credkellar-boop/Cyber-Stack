#include <rte_eal.h>
#include <rte_ethdev.h>
#include <rte_mbuf.h>

#define BURST_SIZE 32

void start_dpdk_packet_loop(uint16_t port_id, uint16_t queue_id) {
    struct rte_mbuf *bufs[BURST_SIZE];
    
    printf("[*] Starting fast-path packet loop on port %u, queue %u...\n", port_id, queue_id);

    while (1) {
        // Retrieve network packets directly into user-space buffers, bypassing the kernel
        const uint16_t nb_rx = rte_eth_rx_burst(port_id, queue_id, bufs, BURST_SIZE);
        
        if (nb_rx == 0) {
            continue;
        }

        // Process packets
        for (uint16_t i = 0; i < nb_rx; i++) {
            // Your telemetry mapping or state verification logic here
            rte_pktmbuf_free(bufs[i]); // Free buffer descriptor instantly
        }
    }
}
