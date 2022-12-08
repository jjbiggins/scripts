#!/bin/bash

LIBTOOL=glibtool ./configure \
	--prefix=#{prefix} \
	--cc=#{ENV.cc} \
	--host-cc=#{ENV.cc} \
      --disable-bsd-user \
      --disable-guest-agent \
      --enable-capstone \
      --enable-curses \
      --enable-libssh \
      --enable-slirp=system \
      --enable-vde \
      --enable-virtfs \
      --enable-zstd \
      --extra-cflags=-DNCURSES_WIDECHAR=1 \
      --disable-sdl
