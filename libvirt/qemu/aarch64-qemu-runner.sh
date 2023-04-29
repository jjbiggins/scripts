#!/bin/bash

if [[ ! -z $1 ]]; then
    IMAGE=$1
else
    IMAGE=FreeBSD-13.1-RELEASE-arm64-aarch64.raw
fi


/opt/local/bin/qemu-system-aarch64 \
  -M virt \
  -accel hvf \
  -cpu host \
  -smp 4 \
  -m 4096 \
  -drive file=/var/lib/libvirt/storage/pflash0.img,format=raw,if=pflash,readonly=on \
  -drive file=/var/lib/libvirt/storage/pflash1.img,format=raw,if=pflash \
  -device virtio-gpu-pci \
  -display default,show-cursor=on \
  -device qemu-xhci \
  -device usb-kbd \
  -device usb-tablet \
  -netdev  vmnet-host,id=vmnet0 \
  -netdev  vmnet-shared,id=shared0 \
  -netdev vmnet-bridged,id=br0,ifname=en0 \
  -netdev vmnet-bridged,id=br1,ifname=en0 \
  -device e1000,netdev=net0 \
  -netdev user,id=net0,hostfwd=tcp::5555-:22 \
  -device intel-hda \
  -device hda-duplex \
  -drive file=${IMAGE},format=raw,if=virtio,cache=writethrough \
  -nographic \
  -serial mon:stdio

#  -netdev user,id=gnet0,net=10.0.2.0/24,dhcpstart=10.0.2.15 \

