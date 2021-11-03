#!/bin/bash

libname=${libname:-library}
old_lib=${old_lib:-}
new_lib=${new_lib:-}
old_ver=${old_ver:-old}
new_ver=${new_ver:-new}

while [ $# -gt 0 ]; do

    if [[ $1 == *"--"* ]]; then
        param="${1/--/}"
        declare $param="$2"
    fi

   shift

done

abi-dumper $old_lib -o ABI-1.dump -lver $old_ver
abi-dumper $new_lib -o ABI-2.dump -lver $new_ver

abi-compliance-checker -l $libname -old ABI-1.dump -new ABI-2.dump
