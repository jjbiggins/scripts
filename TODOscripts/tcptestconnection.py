#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import errno
import os
import sys
import socket
import argparse


def testconnection(HOST, PORT):
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        try:
            s.connect((HOST, PORT))
            s.shutdown(2)
            print(f"SUCCESS: Connected to host {HOST} on port {PORT}")
        except:
            print(f"FAILED: TCP connection to host {HOST} on port {PORT} was unsuccessful") 
            sys.exit(errno.EPERM)


if __name__ == "__main__":
    if len(sys.argv) != 3:
        sys.exit("Usage: python tcptestconnection.py HOSTNAME PORT")
    
    args = sys.argv[1:]

    # check hostname is a string
    assert isinstance(args[0], str)

    # check port is a integer
    print(args[1])
    assert args[1].isdigit()
    args[1] = int(args[1])
    assert isinstance(args[1], int)


    testconnection(*args)


