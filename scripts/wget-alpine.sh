#!/bin/sh

if [ -z "$VERSION" ]; then
  VERSION=v3.24
  echo "VERSION environment variable is not set. Defaulting to $VERSION."
else
  echo "Using VERSION: $VERSION"
fi

wget \
  --mirror \
  --no-parent \
  --no-host-directories \
  --cut-dirs=1 \
  --reject "APKINDEX.tar.gz.sig" \
  "https://dl-cdn.alpinelinux.org/alpine/$VERSION/main/x86_64/"
