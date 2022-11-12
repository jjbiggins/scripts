#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
import sys
import time

def benchmark_runtime(func):
    def wrapper_function(*args, **kwargs):
        t1 = time()
        result = func(*args, **kwargs)
        t2 = time()
        print(f'Function {func.__name__!r} executed in {(t2-t1):.4f}s')
        return result
    return wrapper_function


@function_timer
def long_time(n):
    for i in range(n):
        for j in range(100000):
            i*j
  
  
long_time(5)



