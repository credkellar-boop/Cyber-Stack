#include <stdio.h>
#include <rte_eal.h>
#include <rte_ethdev.h>
#include <rte_mbuf.h>

int init_dpdk_pipeline(int argc, char **argv) {
    int ret;

    // Initialize the Environment Abstraction Layer (EAL)
    ret = rte_eal_init(argc, argv);
    if (ret < 0) {
        rte_exit(EXIT_FAILURE, "Error with EAL initialization\n");
    }

    unsigned nb_ports = rte_eth_dev_count_avail();
    if (nb_ports == 0) {
        printf("Warning: No available Ethernet ports detected for DPDK bypass.\n");
    } else {
        printf("DPDK EAL initialized successfully. Available ports: %u\n", nb_ports);
    }

    return ret;
}
