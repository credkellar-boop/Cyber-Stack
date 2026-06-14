#!/usr/bin/env bash
set -euo pipefail

IMAGE_PATH="/opt/cyberstack/security_fuzzing/images/bullseye.img"
KERNEL_PATH="/usr/src/linux/arch/x86/boot/bzImage"

echo "[*] Booting Syzkaller QEMU Target Virtual Machine..."

qemu-system-x86_64 \
    -m 2G \
    -smp 2 \
    -kernel $KERNEL_PATH \
    -append "console=ttyS0 root=/dev/sda earlyprintk=serial net.ifnames=0" \
    -drive file=$IMAGE_PATH,format=raw \
    -net user,host=10.0.2.10,hostfwd=tcp::10021-:22 \
    -net nic,model=e1000 \
    -nographic \
    -pidfile vm.pid \
    2>&1 | tee vm.log
