#!/bin/bash

GOOGLE=https://www.google.com
SEARCH=search
QUERY=$1 

open "${GOOGLE}/${SEARCH}?q=${QUERY}"


