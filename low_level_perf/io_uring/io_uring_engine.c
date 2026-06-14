#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <liburing.h>

#define QUEUE_DEPTH 256

int init_io_uring_backend(struct io_uring *ring) {
    int ret;

    // Initialize the submission and completion queue rings
    ret = io_uring_queue_init(QUEUE_DEPTH, ring, 0);
    if (ret < 0) {
        fprintf(stderr, "Failed to initialize io_uring queue: %s\n", strerror(-ret));
        return ret;
    }

    printf("io_uring engine initialized successfully with queue depth: %d\n", QUEUE_DEPTH);
    return 0;
}
