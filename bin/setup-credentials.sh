#!/usr/bin/env bash

echo "::group::Set up credentials"

echo -e "\033[;1mWriting configuration file\033[0m" && \
"$_OSSUTIL" config \
    --access-key-id="$OSS_ACCESSKEY_ID" \
    --access-key-secret="$OSS_ACCESSKEY_SECRET" \
    --endpoint="$OSS_ENDPOINT" \
    --config-file="$_OSSUTIL_CONFIG_FILE" \
    --output-dir="$_OSSUTIL_OUTPUT_DIR" && \
echo -e "\033[;1mBlocking access to configuration file from other users or groups\033[0m" && \
chmod 600 "$_OSSUTIL_CONFIG_FILE"

echo "::endgroup::"
