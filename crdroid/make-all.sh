#!/bin/bash

bash <(curl -sL https://github.com/shravansayz/scripts/raw/refs/heads/14.0/crdroid/repo-init.sh) && \
bash <(curl -sL https://github.com/shravnsayz/scripts/raw/refs/heads/14.0/crdroid/local-manifest.sh) && \
bash <(curl -sL https://github.com/shravansayz/scripts/raw/refs/heads/14.0/utils/repo-sync.sh) && \
bash <(curl -sL https://github.com/shravansayz/scripts/raw/refs/heads/14.0/crdroid/build.sh) && \
bash <(curl -sL https://github.com/shravansayz/scripts/raw/refs/heads/14.0/utils/upload.sh) 'out/target/product/*/*.img'
