#!/bin/bash

/opt/local/bin/qemu-system-aarch64 \
    -M virt \
    -accel hvf \
    -cpu host \
    -smp 4 \
    -m 4096 \
    -drive file=pflash0.img,format=raw,if=pflash,readonly=on \
    -drive file=pflash1.img,format=raw,if=pflash \
    -device virtio-gpu-pci \
    -display default,show-cursor=on \
    -device qemu-xhci \
    -device usb-kbd \
    -device usb-tablet \
    -device intel-hda \
    -device hda-duplex \
    -drive file=FreeBSD-13.1-RELEASE-arm64-aarch64.raw,format=raw,if=virtio,cache=writethrough \
    -nographic \
    -serial mon:stdio
