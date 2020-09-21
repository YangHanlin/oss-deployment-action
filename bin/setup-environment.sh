#!/usr/bin/env bash

echo "::group::Set up environment"

# Expand paths

echo -e "\033[;1mExpanding paths\033[0m"

LOCAL_PATH=${LOCAL_PATH/#~/$HOME}
_OSSUTIL_WORKSPACE=${_OSSUTIL_WORKSPACE/#~/$HOME}

# Export common environment variables

echo -e "\033[;1mExporting environment variables to be used in later steps\033[0m"

echo "::set-env name=OSS_ENDPOINT::$OSS_ENDPOINT"
echo "::set-env name=OSS_PATH::$OSS_PATH"
echo "::set-env name=LOCAL_PATH::$LOCAL_PATH"
echo "::set-env name=IGNORED_PATTERNS::$IGNORED_PATTERNS"
echo "::set-env name=DELETE_FIRST::$DELETE_FIRST"

echo "::set-env name=_OSSUTIL_DOWNLOAD_URL::$_OSSUTIL_DOWNLOAD_URL"
echo "::set-env name=_OSSUTIL_WORKSPACE::$_OSSUTIL_WORKSPACE"
echo "::set-env name=_OSSUTIL::$_OSSUTIL_WORKSPACE/ossutil"
echo "::set-env name=_OSSUTIL_CONFIG_FILE::$_OSSUTIL_WORKSPACE/.ossutilconfig"
echo "::set-env name=_OSSUTIL_OUTPUT_DIR::$_OSSUTIL_WORKSPACE/output_dir"
echo "::set-env name=_OSSUTIL_BACKUP_DIR::$_OSSUTIL_WORKSPACE/backup_dir"

# Create ossutil workspace (if not exist)

echo -e "\033[;1mCreating workspace for ossutil\033[0m"

if [[ -n $_OSSUTIL_WORKSPACE ]]; then
    mkdir -p "$_OSSUTIL_WORKSPACE"
fi

echo "::endgroup::"
