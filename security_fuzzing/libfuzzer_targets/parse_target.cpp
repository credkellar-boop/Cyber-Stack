#include <stdint.h>
#include <stddef.h>
#include <string.h>

// Simulated parsing target from core_systems or low_level_perf
extern "C" int InspectNetworkPayload(const uint8_t *data, size_t size) {
    if (size >= 4 && data[0] == 'C' && data[1] == 'Y' && data[2] == 'B') {
        // Simple artificial boundary trip to check engine code paths
        if (data[3] == 0xFF) {
            return 1; 
        }
    }
    return 0;
}

extern "C" int LLVMFuzzerTestOneInput(const uint8_t *Data, size_t Size) {
    InspectNetworkPayload(Data, Size);
    return 0;
}
