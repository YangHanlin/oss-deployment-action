#!/usr/bin/env bash

source "$(dirname $0)/common.sh"

prepare_variables() {
    start_group "Prepare variables"

    if [[ "$RUNNER_OS" == "Windows" ]]; then
        OS_TYPE=windows
        OSSUTIL_EXECUTABLE_NAME=ossutil64.exe
    elif [[ "$RUNNER_OS" == "Linux" ]]; then
        OS_TYPE=linux
        OSSUTIL_EXECUTABLE_NAME=ossutil64
    elif [[ "$RUNNER_OS" == "macOS" ]]; then
        OS_TYPE=mac
        OSSUTIL_EXECUTABLE_NAME=ossutilmac64
    else
        log "Error: unsupported runner OS '$RUNNER_OS'"
        exit 1
    fi

    # Currently only AMD64 architecture is supported
    if [[ "$RUNNER_ARCH" == "X64" ]]; then
        ARCH_TYPE=amd64
    else
        log "Error: unsupported runner architecture '$RUNNER_ARCH'"
        exit 1
    fi

    WORKSPACE="$RUNNER_TEMP/oss-deployment-action"
    OSSUTIL_SPEC="ossutil-v$OSSUTIL_VERSION-$OS_TYPE-$ARCH_TYPE"
    OSSUTIL_DOWNLOAD_URL="https://gosspublic.alicdn.com/ossutil/$OSSUTIL_VERSION/$OSSUTIL_SPEC.zip"
    CACHE_KEY="oss-deployment-action-$OSSUTIL_SPEC"

    set_output os-type "$OS_TYPE"
    set_output arch-type "$ARCH_TYPE"
    set_output workspace "$WORKSPACE"
    set_output ossutil-executable-name "$OSSUTIL_EXECUTABLE_NAME"
    set_output ossutil-spec "$OSSUTIL_SPEC"
    set_output ossutil-download-url "$OSSUTIL_DOWNLOAD_URL"
    set_output cache-key "$CACHE_KEY"

    end_group
}

prepare_variables
