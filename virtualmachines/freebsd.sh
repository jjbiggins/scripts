#!/bin/bash


qemu-system-i386 \
    -drive file=/shared/VM-IMAGES//FreeBSD-13.1-RELEASE-i386.qcow2,format=qcow2 \
    -m 512 \
    -nographic

