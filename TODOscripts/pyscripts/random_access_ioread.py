#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
import sys
# Read in the file once and build a list of line offsets
line_offset = []
offset = 0
for line in file:
    line_offset.append(offset)
    offset += len(line)
file.seek(0)

# Now, to skip to line n (with the first line being line 0), just do
file.seek(line_offset[n])



