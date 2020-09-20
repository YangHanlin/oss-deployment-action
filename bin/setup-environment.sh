#!/usr/bin/env bash

# Export common environment variables

echo "::set-env name=OSS_ENDPOINT::$OSS_ENDPOINT"
echo "::set-env name=OSS_PATH::$OSS_PATH"
echo "::set-env name=LOCAL_PATH::$LOCAL_PATH"
echo "::set-env name=IGNORED_PATTERNS::$IGNORED_PATTERNS"
echo "::set-env name=DELETE_FIRST:$DELETE_FIRST"

echo "::set-env name=_OSSUTIL_DOWNLOAD_URL:$_OSSUTIL_DOWNLOAD_URL"
echo "::set-env name=_OSSUTIL_WORKSPACE::$_OSSUTIL_WORKSPACE"
echo "::set-env name=_OSSUTIL::$_OSSUTIL_WORKSPACE/ossutil"
echo "::set-env name=_OSSUTIL_CONFIG_FILE::$_OSSUTIL_WORKSPACE/.ossutilconfig"
echo "::set-env name=_OSSUTIL_OUTPUT_DIR::$_OSSUTIL_WORKSPACE/output_dir"
echo "::set-env name=_OSSUTIL_BACKUP_DIR::$_OSSUTIL_WORKSPACE/backup_dir"

# Create ossutil workspace (if not exist)

if [[ -n $_OSSUTIL_WORKSPACE ]]; then
    mkdir -p "$_OSSUTIL_WORKSPACE"
fi
