#!/bin/bash



VM_MACHINE_PARDIR=/pub/vm
FORMAT=raw

IMG_FILE=$1
RO_IMG=pflash0.img
RW_IMG=pflash1.img


IMG_PATH=${VM_MACHINE_PARDIR}/${IMG_FILE}
RO_DRIVE=${VM_MACHINE_PARDIR}/${RO_IMG}
RW_DRIVE=${VM_MACHINE_PARDIR}/${RW_IMG}

echo $RO_DRIVE

#qemu-system-aarch64 
/Users/jjbiggins/qemu-7.1.0/build/qemu-system-aarch64-unsigned \
    -monitor stdio \
    -machine virt \
    -accel hvf \
    -cpu host \
    -smp 4 \
    -m 3G \
    -drive file=${RO_DRIVE},format=${FORMAT},if=pflash,readonly=on \
    -drive file=${RW_DRIVE},format=${FORMAT},if=pflash \
    -device ramfb \
    -device qemu-xhci \
    -device usb-kbd \
    -device usb-tablet \
    -device intel-hda \
    -device hda-duplex  \
    -nic user,model=virtio \
    -drive file=${IMG_PATH},format=${FORMAT},if=none,id=boot,cache=writethrough \
    -device nvme,drive=boot,serial=boot \
    -boot c
    
    #-device intel-hda \
    #-device hda-duplex \


# TODO:
# evaluate how to add networking to vm
#-device virtio-net,netdev=net0 \
#-netdev socket,id=net0,udp=:2233,localaddr=:1122
