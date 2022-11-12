#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
import sys
# assign directory
directory = 'unsorted_scripts'
 
# iterate over files in
# that directory
for filename in os.listdir(directory):

    print(filename)
    f = os.path.join(directory, filename)
    # checking if it is a file
    if os.path.isfile(f):
        print(f)



def recursive_directory_tree(tree_obj):
    

    if not os.path.isdir(tree_obj):
        return

    else:
        tree_obj.path.












