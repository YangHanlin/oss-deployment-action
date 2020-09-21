#!/usr/bin/env bash

echo "::group::Set up credentials"

echo "Writing configuration file" && \
"$_OSSUTIL" config \
    --access-key-id="$OSS_ACCESSKEY_ID" \
    --access-key-secret="$OSS_ACCESSKEY_SECRET" \
    --endpoint="$OSS_ENDPOINT" \
    --config-file="$_OSSUTIL_CONFIG_FILE" \
    --output-dir="$_OSSUTIL_OUTPUT_DIR" && \
echo "Blocking access to configuration file from other users or groups" && \
chmod 600 "$_OSSUTIL_CONFIG_FILE"

echo "::endgroup::"
