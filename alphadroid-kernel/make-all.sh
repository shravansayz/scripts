#!/bin/bash

bash <(curl -sL https://github.com/xiaomi-sweet2/scripts/raw/refs/heads/14.0/alphadroid-kernel/repo-init.sh) && \
bash <(curl -sL https://github.com/xiaomi-sweet2/scripts/raw/refs/heads/14.0/alphadroid-kernel/local-manifest.sh) && \
bash <(curl -sL https://github.com/xiaomi-sweet2/scripts/raw/refs/heads/14.0/utils/repo-sync.sh) && \
bash <(curl -sL https://github.com/xiaomi-sweet2/scripts/raw/refs/heads/14.0/alphadroid-kernel/build.sh) && \
bash <(curl -sL https://github.com/xiaomi-sweet2/scripts/raw/refs/heads/14.0/utils/upload.sh) 'out/target/product/*/*.img'
