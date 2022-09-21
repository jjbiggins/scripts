#!/bin/bash

RAM=512
CPUS=host
QEMU_EFI=/opt/pkg/share/qemu/edk2-aarch64-code.fd
IMAGE=$1

#-display none \
qemu-system-aarch64 \
    -m ${RAM} \
    -cpu cortex-a57 -machine virt \
    -bios ${QEMU_EFI} \
    -device virtio-scsi-device,id=scsi \
    -drive file=${IMAGE},format=raw,if=none,id=hd0 -device scsi-hd,drive=hd0 \
    -netdev user,id=usernet -device virtio-net-device,netdev=usernet \
    -boot d \
    -serial mon:stdio


