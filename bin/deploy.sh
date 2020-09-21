#!/usr/bin/env bash

echo "::group::Perform deployment"

if [[ $DELETE_FIRST == true ]]; then
    echo -e "\033[34mInput parameter 'delete-first' is set to true; deleting existing files\033[0m" && \
    "$_OSSUTIL" rm \
        --config-file="$_OSSUTIL_CONFIG_FILE" \
        --recursive \
        --force \
        "$OSS_PATH"
fi

echo -e "\033[34mRemoving ignored files\033[0m" && \
mkdir -p "$_OSSUTIL_BACKUP_DIR" && \
mv $IGNORED_PATTERNS "$_OSSUTIL_BACKUP_DIR/" && \
echo -e "\033[34mUploading files\033[0m" && \
"$_OSSUTIL" cp \
    --config-file="$_OSSUTIL_CONFIG_FILE" \
    --recursive \
    --update \
    "$LOCAL_PATH" \
    "$OSS_PATH" && \
echo -e "\033[34mRestoring ignored files\033[0m" && \
(mv "$_OSSUTIL_BACKUP_DIR"/{*,.[^.]*} ./ || true)

echo "::endgroup::"
