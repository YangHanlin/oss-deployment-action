#!/usr/bin/env bash

if [[ $DELETE_FIRST == true ]]; then
    "$_OSSUTIL" rm \
        --config-file="$_OSSUTIL_CONFIG_FILE" \
        --recursive \
        --force \
        "$OSS_PATH"
fi

mkdir -p "$_OSSUTIL_BACKUP_DIR" && \
mv $IGNORED_PATTERNS "$_OSSUTIL_BACKUP_DIR/" && \
"$_OSSUTIL" cp \
    --config-files="$_OSSUTIL_CONFIG_FILE" \
    --recursive \
    --update \
    "$LOCAL_PATH" \
    "$OSS_PATH" && \
mv "$_OSSUTIL_BACKUP_DIR/*" .
