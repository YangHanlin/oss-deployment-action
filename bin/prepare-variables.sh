#!/usr/bin/env bash

source "$(dirname $0)/common.sh"

prepare_variables() {
    start_group "Prepare variables"

    set_output workspace "$RUNNER_TEMP/oss-deployment-action"
    set_output ossutil-download-url "https://gosspublic.alicdn.com/ossutil/$OSSUTIL_VERSION/ossutil64"
    set_output cache-key "$RUNNER_OS-oss-deployment-action-$OSSUTIL_VERSION"

    end_group
}

prepare_variables
