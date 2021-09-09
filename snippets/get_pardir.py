#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
import sys

def get_pardir():
    print("os.path.abspath(os.path.join(os.cwd(), os.pardir))")

if __name__ == '__main__':
    get_pardir()

