#!/usr/bin/env bash

echo "::group::Set up environment"

# Expand paths

echo -e "\033[34mExpanding paths\033[0m"

LOCAL_PATH=${LOCAL_PATH/#~/$HOME}
_OSSUTIL_WORKSPACE=${_OSSUTIL_WORKSPACE/#~/$HOME}

# Export common environment variables

echo -e "\033[34mExporting environment variables to be used in later steps\033[0m"

echo "OSS_ENDPOINT=$OSS_ENDPOINT" >>$GITHUB_ENV
echo "OSS_PATH=$OSS_PATH" >>$GITHUB_ENV
echo "LOCAL_PATH=$LOCAL_PATH" >>$GITHUB_ENV
echo "IGNORED_PATTERNS=$IGNORED_PATTERNS" >>$GITHUB_ENV
echo "DELETE_FIRST=$DELETE_FIRST" >>$GITHUB_ENV

echo "_OSSUTIL_DOWNLOAD_URL=$_OSSUTIL_DOWNLOAD_URL" >>$GITHUB_ENV
echo "_OSSUTIL_WORKSPACE=$_OSSUTIL_WORKSPACE" >>$GITHUB_ENV
echo "_OSSUTIL=$_OSSUTIL_WORKSPACE/ossutil" >>$GITHUB_ENV
echo "_OSSUTIL_CONFIG_FILE=$_OSSUTIL_WORKSPACE/.ossutilconfig" >>$GITHUB_ENV
echo "_OSSUTIL_OUTPUT_DIR=$_OSSUTIL_WORKSPACE/output_dir" >>$GITHUB_ENV
echo "_OSSUTIL_BACKUP_DIR=$_OSSUTIL_WORKSPACE/backup_dir" >>$GITHUB_ENV

# Create ossutil workspace (if not exist)

echo -e "\033[34mCreating workspace for ossutil\033[0m"

if [[ -n $_OSSUTIL_WORKSPACE ]]; then
    mkdir -p "$_OSSUTIL_WORKSPACE"
fi

echo "::endgroup::"
