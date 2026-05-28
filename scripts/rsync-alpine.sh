#!/bin/sh
if [ -z "$VERSION" ]; then
  VERSION=v3.23.4
  echo "VERSION environment variable is not set. Defaulting to $VERSION."
else
  echo "Using VERSION: $VERSION"
fi
# Lock to prevent concurrent runs
lockfile="/tmp/alpine-mirror.lock"
[ -z "$flock" ] && exec env flock=1 flock -n $lockfile "$0" "$@"

# Define source and destination
src="rsync://rsync.alpinelinux.org/alpine/"

# Rsync only the latest version and selected repos/archs
rsync \
  --archive \
  --update \
  --hard-links \
  --delete \
  --delete-after \
  --delay-updates \
  --timeout=600 \
  --include "$VERSION/" \
  --include "$VERSION/main/" \
  --include "$VERSION/main/x86_64/***" \
  --exclude "*" \
  "$src" "."


  # --log-file "rsync.log" \
  # --include "$VERSION/community/" \
  # --include "$VERSION/community/x86_64/" \
  # --include "latest-stable/" \
  # --include "latest-stable/main/" \
  # --include "latest-stable/main/x86_64/" \
  # --include "latest-stable/community/" \
  # --include "latest-stable/community/x86_64/" \