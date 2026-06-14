#include "io_uring_engine.h"
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>

int submit_async_read(struct io_uring *ring, int fd, void *buffer, size_t size, off_t offset) {
    struct io_uring_sqe *sqe = io_uring_get_sqe(ring);
    if (!sqe) {
        fprintf(stderr, "Could not get SQE from io_uring\n");
        return -1;
    }

    // Prepare an asynchronous read operation
    io_uring_prep_read(sqe, fd, buffer, size, offset);
    
    // Set user data to track the completion of this specific request
    io_uring_sqe_set_data(sqe, buffer);

    // Submit the queue entry to the kernel
    return io_uring_submit(ring);
}

void wait_for_completion(struct io_uring *ring) {
    struct io_uring_cqe *cqe;
    int ret = io_uring_wait_cqe(ring, &cqe);
    
    if (ret < 0) {
        fprintf(stderr, "Error waiting for CQE\n");
        return;
    }

    // Retrieve the buffer we passed in sqe_set_data
    void *buffer = io_uring_cqe_get_data(cqe);
    printf("Async read completed successfully into buffer: %p\n", buffer);

    // Mark this completion queue entry as processed
    io_uring_cqe_seen(ring, cqe);
}
