#!/usr/bin/env bash

source "$(dirname $0)/common.sh"

# Set up environment

setup_workspace() {
    log "Setting up workspace"

    mkdir -p "$WORKSPACE"
}

try_ossutil() {
    log "Trying to find existing ossutil from PATH"

    if type ossutil >/dev/null 2>&1; then
        OSSUTIL=ossutil

        log "Found existing ossutil"
        type ossutil
    else
        log "ossutil does not exist or is not executable"
    fi
}

setup_ossutil() {
    log "Setting up ossutil"

    OSSUTIL_BINARY="$WORKSPACE/ossutil"
    OSSUTIL_CONFIG_FILE="$WORKSPACE/.ossutilconfig"
    OSSUTIL_OUTPUT_DIR="$WORKSPACE/ossutil-output"
    OSSUTIL="$OSSUTIL_BINARY --config-file=$OSSUTIL_CONFIG_FILE"

    if [[ -f "$OSSUTIL_BINARY" ]]; then
        log "Using ossutil from cache"
    else
        log "Downloading ossutil"
        curl -L -o "$OSSUTIL_BINARY" "$OSSUTIL_DOWNLOAD_URL"
    fi
    chmod u+x "$OSSUTIL_BINARY"

    log "Configuring ossutil"
    CONFIG_OPTIONS=(
        "--output-dir=$OSSUTIL_OUTPUT_DIR"
    )
    if [[ "$OSS_ENDPOINT" != "" ]]; then
        CONFIG_OPTIONS+=(
            "--endpoint=$OSS_ENDPOINT"
        )
    else
        log "Error: 'oss-endpoint' is required but not provided"
        exit 1
    fi
    if [[ "$OSS_ACCESSKEY_ID" != "" ]]; then
        CONFIG_OPTIONS+=(
            "--access-key-id=$OSS_ACCESSKEY_ID"
        )
    fi
    if [[ "$OSS_ACCESSKEY_SECRET" != "" ]]; then
        CONFIG_OPTIONS+=(
            "--access-key-secret=$OSS_ACCESSKEY_SECRET"
        )
    fi
    if [[ "$OSS_STS_TOKEN" != "" ]]; then
        CONFIG_OPTIONS+=(
            "--sts-token=$OSS_STS_TOKEN"
        )
    fi
    $OSSUTIL config "${CONFIG_OPTIONS[@]}"
    chmod 600 "$OSSUTIL_CONFIG_FILE"
}

setup_environment() {
    start_group "Set up environment"

    setup_workspace
    if [[ "$FORCE_SETUP_OSSUTIL" == "" ]]; then
        find_ossutil
    fi
    if [[ "$OSSUTIL" == "" ]]; then
        setup_ossutil
    fi

    end_group
}

# Perform deployment

delete_existing_files() {
    log "Deleting existing files"
    $OSSUTIL rm \
        --recursive \
        --force \
        "$OSS_PATH"
}

remove_ignored_files() {
    log "Removing ignored files"
    BACKUP_DIR="$WORKSPACE/backup-$(date +%s)"
    mkdir -p "$BACKUP_DIR"
    mv $IGNORED_PATTERNS "$BACKUP_DIR/" || true
}

upload_files() {
    log "Uploading files"
    $OSSUTIL cp \
        --recursive \
        --update \
        "$LOCAL_PATH" \
        "$OSS_PATH"
}

restore_ignored_files() {
    log "Restoring ignored files"
    (mv "$BACKUP_DIR"/{*,.[^.]*} ./ || true)
}

perform_deployment() {
    start_group "Perform deployment"

    if [[ "$DELETE_FIRST" == "true" ]]; then
        delete_existing_files
    fi
    remove_ignored_files
    upload_files
    restore_ignored_files

    end_group
}

# Clear environment

clear_credentials() {
    if [[ "$OSSUTIL_CONFIG_FILE" != "" ]]; then
        log "Removing configuration file"
        rm -f "$OSSUTIL_CONFIG_FILE"
    else
        log "Not removing configration file because it is not managed by this action"
    fi
}

clear_environment() {
    start_group "Clear environment"

    clear_credentials

    end_group
}

setup_environment
perform_deployment
clear_environment
