#!/bin/sh

path_file="$1"

attribute_testcase=$(xmlstarlet sel -t -m "//testcase" -v "@name" "$path_file")

string=$attribute_testcase
regex="Class:(.*?)\|"

if [[ $string =~ $regex ]]; then
	extracted="${BASH_REMATCH[1]}"
else
	extracted=$attribute_testcase
fi

while IFS= read -r testcase; do
  xmlstarlet ed -L -i "//testcase[@name='$testcase']" -t attr -n "programa" -v "$extracted" "$path_file"
done <<< "$attribute_testcase"
