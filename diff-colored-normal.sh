#!/bin/bash

# Name of GNU sed on my Mac OS X
SED=gsed

for resolver in 2.22 6.19 7.0; do
    # Remove http://superuser.com/a/380778/46794
    echo LTS-$resolver
    echo
    diff -u <($SED 's/\x1b\[[0-9;]*m//g' < compiler-outs/BenchSum-lts-$resolver-color.corehs ) compiler-outs/BenchSum-lts-$resolver.corehs
    echo
done
