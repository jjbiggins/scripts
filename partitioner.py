#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
import sys


def set_partitions_helper(L, k):
    n = len(L)
    if k == 1:
        yield [L]
    elif n == k:
        yield [[s] for s in L]
    else:
        e, *M = L

        print(f"0: e={e}, M={M}")
        for p in set_partitions_helper(M, k - 1):
            print(f"1st: e={e}, p={p}, M={M}, k={k}")
            yield [[e], *p]
        for p in set_partitions_helper(M, k):
            print(f"2nd: e={e}, p={p}, M={M}, k={k}")
            for i in range(len(p)):
                yield p[:i] + [[e] + p[i]] + p[i + 1 :]

        

lst = [2,3,5]
print(list(set_partitions_helper(lst, 2)))

