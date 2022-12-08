#!/bin/bash

test1 () {
	echo "Running test1....."
	[[ ! -x /proc ]]  &&  return 1
	echo "exit code: $?; /proc exists"
	echo ""
}

test2 () {
	echo "Running test2....."
	[[ ! -d /fakedir ]] && return 1
	echo "exit code: $?; /fakedir does NOT exist"
	echo ""
}




test3() {
	echo "$0 ran...program was never terminated"
}





testreturnfunc () {
	test1
	test2
	test3
}


testreturnfunc
