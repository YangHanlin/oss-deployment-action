#!/usr/bin/env bash

echo "::group::Clear credentials"

echo "Removing configuration file" && \
rm -f "$_OSSUTIL_CONFIG_FILE"

echo "::endgroup::"
