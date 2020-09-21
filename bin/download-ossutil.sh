#!/usr/bin/env bash

echo "::group::Download ossutil"

if [[ -f "$_OSSUTIL" ]]; then
    echo -e "\033[34mSkipping because ossutil already exists\033[0m"
else
    echo -e "\033[34mDownloading ossutil\033[0m" && \
    wget -O "$_OSSUTIL" "$_OSSUTIL_DOWNLOAD_URL" && \
    echo -e "\033[34mGranting execution privilege to ossutil\033[0m" && \
    chmod +x "$_OSSUTIL"
fi

echo "::endgroup::"
