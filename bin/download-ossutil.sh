#!/usr/bin/env bash

echo "::group::Download ossutil"

echo "Downloading ossutil" && \
wget -O "$_OSSUTIL" "$_OSSUTIL_DOWNLOAD_URL" && \
echo "Granting execution privilege to ossutil" && \
chmod +x "$_OSSUTIL"

echo "::endgroup::"
