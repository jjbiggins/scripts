#!/bin/bash



VM_MACHINE_PARDIR=/shared/vm
OS=fedora
VERSION=36
TYPE=server
FORMAT=raw

IMG_FILE=Fedora-Server-36-1.5.aarch64.raw
RO_IMG=pflash0.img
RW_IMG=pflash1.img


IMG_PATH=${VM_MACHINE_PARDIR}/${OS}/${VERSION}/${TYPE}/${FORMAT}/${IMG_FILE}
RO_DRIVE=${VM_MACHINE_PARDIR}/${OS}/${VERSION}/${TYPE}/${FORMAT}/${RO_IMG}
RW_DRIVE=${VM_MACHINE_PARDIR}/${OS}/${VERSION}/${TYPE}/${FORMAT}/${RW_IMG}


qemu-system-aarch64 \
    -machine virt \
    -accel hvf \
    -cpu host \
    -smp 4 \
    -m 4096 \
    -drive file=${RO_DRIVE},format=${FORMAT},if=pflash,readonly=on \
    -drive file=${RW_DRIVE},format=${FORMAT},if=pflash \
    -device virtio-gpu-pci \
    -display default,show-cursor=on \
    -device qemu-xhci \
    -device usb-kbd \
    -device usb-tablet \
    -device intel-hda \
    -device hda-duplex \
    -drive file=${IMG_PATH},format=${FORMAT},if=virtio,cache=writethrough \
    -nographic \
    -serial mon:stdio


# TODO:
# evaluate how to add networking to vm
#-device virtio-net,netdev=net0 \
#-netdev socket,id=net0,udp=:2233,localaddr=:1122
