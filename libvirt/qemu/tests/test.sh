#!/bin/bash
qemu-system-aarch64 -M virt -nographic -cpu max -smp 2 -m 1024 -device virtio-gpu-pci \
-cdrom /Users/jjbiggins/Downloads/Fedora-Everything-netinst-aarch64-36-1.5.iso  -hda -format raw /Users/jjbiggins/Downloads/fedora-img
