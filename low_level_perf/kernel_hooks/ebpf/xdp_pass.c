#include <linux/bpf.h>
#include <bpf/bpf_helpers.h>

SEC("xdp")
int xdp_pass_prog(struct xdp_md *ctx) {
    // Implement direct packet inspection or logging layers here
    // Currently acting as a low-overhead telemetry pass-through
    return XDP_PASS;
}

char _license[] SEC("license") = "GPL";
