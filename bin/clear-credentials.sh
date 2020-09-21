#!/usr/bin/env bash

echo "::group::Clear credentials"

echo -e "\033[;1mRemoving configuration file\033[0m" && \
rm -f "$_OSSUTIL_CONFIG_FILE"

echo "::endgroup::"
