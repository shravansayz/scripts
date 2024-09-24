#!/bin/bash

rm -rf .repo/local_manifests && \

if [ ! -d vendor/lineage-priv ]; then
    echo -e "\n--------------------- [WARNING] ---------------------"
    echo "No ROM keys in vendor/lineage-priv"
    echo -e "--------------------- [WARNING] ---------------------\n"
fi

echo -e "\n--------------------- [INFO] ---------------------"
if [ -d out/target/product/ ]; then
    echo "ls of out/target/product/*:"
    ls out/target/product/*
else
    echo "out/target/product doesn't exists"
fi
echo -e "--------------------- [INFO] ---------------------\n"
