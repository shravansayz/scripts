#!/bin/bash

bash <(curl -sL https://github.com/xiaomi-sweet2/scripts/raw/refs/heads/14.0/utils/crave/prepare.sh) && \
bash <(curl -sL https://github.com/xiaomi-sweet2/scripts/raw/refs/heads/14.0/lineage/repo-init.sh) && \
bash <(curl -sL https://github.com/xiaomi-sweet2/scripts/raw/refs/heads/14.0/lineage/local-manifest.sh) && \
bash <(curl -sL https://github.com/xiaomi-sweet2/scripts/raw/refs/heads/14.0/utils/crave/repo-sync.sh) && \
bash <(curl -sL https://github.com/xiaomi-sweet2/scripts/raw/refs/heads/14.0/lineage/build.sh) && \
bash <(curl -sL https://github.com/xiaomi-sweet2/scripts/raw/refs/heads/14.0/utils/upload.sh) 'out/target/product/*/*.zip'
