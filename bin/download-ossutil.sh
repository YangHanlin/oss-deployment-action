#!/usr/bin/env bash

echo "::group::Download ossutil"

echo -e "\033[;1mDownloading ossutil\033[0m" && \
wget -O "$_OSSUTIL" "$_OSSUTIL_DOWNLOAD_URL" && \
echo -e "\033[;1mGranting execution privilege to ossutil\033[0m" && \
chmod +x "$_OSSUTIL"

echo "::endgroup::"
