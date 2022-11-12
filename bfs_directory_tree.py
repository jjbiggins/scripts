#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
import sys
import ctypes


def bfs(root):

    queue = []
    visited  = {root: False}


    queue.append(os.path.abspath(root))
    visited[os.path.abspath(root)] = True

    while queue:

        node = queue.pop(0)
        if os.path.isfile(node):
            pass
        else:
    
            for child_node in os.listdir(node):
                child_node_path = '/'.join([node,child_node])

                if os.path.basename(node).startswith('.'):
                    visited[child_node_path] = True

                if child_node_path not in list(visited.keys()):
                    queue.append(child_node_path)
                    if os.path.isfile(child_node_path) and not os.path.basename(child_node_path).startswith('.'):
                        print(child_node_path)
                    visited[child_node_path] = True

if __name__ == "__main__":
    bfs(sys.argv[1])

