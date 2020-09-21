#!/usr/bin/env bash

"$_OSSUTIL" config \
    --access-key-id="$OSS_ACCESSKEY_ID" \
    --access-key-secret="$OSS_ACCESSKEY_SECRET" \
    --endpoint="$OSS_ENDPOINT" \
    --config-file="$_OSSUTIL_CONFIG_FILE" \
    --output-dir="$_OSSUTIL_OUTPUT_DIR" && \
chmod 600 "$_OSSUTIL_CONFIG_FILE"
