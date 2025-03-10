#!/usr/bin/env bash

shopt -s globstar

programs="vesktop"

IFS=':'
read -r -a paths <<< "$XDG_DATA_DIRS"

for path in $XDG_DATA_DIRS
do
  if test -d "$path"; then
	# https://stackoverflow.com/a/54561526
	find "$path" -name '*.desktop' -print0 | grep -a -z -E $programs | while read -d $'\0' file
	do
		if ! grep -q -- "--disable-gpu" $file; then
			echo $(sed "/Exec=/ s/$/ --disable-gpu-compositing --disable-gpu/" $file) > $file
			echo "patched $(basename $file)"
		fi
	done
  fi
done
