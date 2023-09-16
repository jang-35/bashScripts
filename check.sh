#!/bin/sh

dir=''
while [ $# -gt 0 ] ; do
	if [ "$1" = "-d" ] ; then
		dir=y
		shift
		continue
	else
		if [ -n "$dir" ] ; then
			if [ -d "$1" ] ; then
				echo "$1 is a directory"
			else
				echo "$1 is not a directory"
			fi
		else
			if [ -e "$1" ] ; then
				echo "$1 exists"
			else
				echo "$1 does not exist" 
			fi
		fi
		dir=''
	fi
	shift
done
