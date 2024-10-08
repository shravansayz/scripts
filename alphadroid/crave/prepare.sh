#!/bin/bash

rm -rf .repo/local_manifests && \

if [ ! -d vendor/lineage-priv ]; then
    echo -e "\n--------------------- [WARNING] ---------------------"
    echo "No ROM keys in vendor/lineage-priv"
    echo -e "--------------------- [WARNING] ---------------------\n"
fi

echo -e "\n--------------------- [INFO] ---------------------"
echo "ls of out/target/product/*:"
ls out/target/product/*
echo -e "--------------------- [INFO] ---------------------\n"

echo -e "\n--------------------- [INFO] ---------------------"
echo "Installing ffsend..."
sudo bash -c "$(curl -sL https://gist.githubusercontent.com/marat2509/ce5e20431e3c8c8fd201488e303e1bd6/raw/ffsend-install.sh)" --
echo -e "--------------------- [INFO] ---------------------\n"
