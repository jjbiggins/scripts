#!/bin/bash


RAW_IMG_BASE=$1

VM_PARDIR=/shared/vm
VM_DIR="${VM_PARDIR}/${RAW_IMG_BASE}"
VM_BOOT_DIR="${VM_DIR}/boot"
VM_DEV_DIR="${VM_DIR}/dev"

RO_IMG="${VM_DEV_DIR}/pflash0.img"
RW_IMG="${VM_DEV_DIR}/pflash1.img"

VM_IMG="${VM_BOOT_DIR}/${RAW_IMG_BASE}.raw"

qemu-system-i386 \
    -net nic,model=virtio \
    -net user \
    -drive file=${VM_IMG},media=disk,cache=none,format=raw \
    -serial mon:stdio \
    -machine type=pc \
    -m 512 \
    -nographic
