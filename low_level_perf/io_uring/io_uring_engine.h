#ifndef CYBER_STACK_IO_URING_ENGINE_H
#define CYBER_STACK_IO_URING_ENGINE_H

#include <liburing.h>

#ifdef __cplusplus
extern "C" {
#endif

/**
 * Initializes the global asynchronous I/O context ring.
 * @param ring Pointer to unallocated io_uring context structure.
 * @return 0 on success, negative error code on structural failure.
 */
int init_io_uring_backend(struct io_uring *ring);

#ifdef __cplusplus
}
#endif

#endif // CYBER_STACK_IO_URING_ENGINE_H
