#ifndef CYBER_STACK_SYSCALL_DEFS_H
#define CYBER_STACK_SYSCALL_DEFS_H

#include <linux/ioctl.h>

struct cyberstack_io_struct {
    uint64_t buffer_addr;
    uint32_t buffer_len;
    uint32_t priority;
};

// Define magic numbers for your custom ioctl interface
#define CYBER_MAGIC 'c'
#define CYBER_IOC_SEND _IOW(CYBER_MAGIC, 1, struct cyberstack_io_struct)
#define CYBER_IOC_RECV _IOR(CYBER_MAGIC, 2, struct cyberstack_io_struct)

#endif
