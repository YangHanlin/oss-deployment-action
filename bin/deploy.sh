#!/usr/bin/env bash

echo "::group::Perform deployment"

if [[ $DELETE_FIRST == true ]]; then
    echo "Input parameter 'delete-first' is set to true; deleting existing files" && \
    "$_OSSUTIL" rm \
        --config-file="$_OSSUTIL_CONFIG_FILE" \
        --recursive \
        --force \
        "$OSS_PATH"
fi

echo "Removing ignored files" && \
mkdir -p "$_OSSUTIL_BACKUP_DIR" && \
mv $IGNORED_PATTERNS "$_OSSUTIL_BACKUP_DIR/" && \
echo "Uploading files" && \
"$_OSSUTIL" cp \
    --config-file="$_OSSUTIL_CONFIG_FILE" \
    --recursive \
    --update \
    "$LOCAL_PATH" \
    "$OSS_PATH" && \
echo "Restoring ignored files" && \
(mv "$_OSSUTIL_BACKUP_DIR"/{*,.[^.]*} ./ || true)

echo "::endgroup::"
