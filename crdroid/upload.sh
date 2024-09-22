#!/bin/bash

for f in $(find out/target/product/*/*.zip); do
    echo -n "$f: " && curl -F "file=@$f" https://temp.sh/upload >> result.txt
done
