#!/usr/bin/env bash

set -e

if [[ "$DEBUG" == "true" ]]; then
    set -x
fi

# Utilities

start_group() {
    echo "::group::$1"
}

end_group() {
    echo "::endgroup::"
}

set_output() {
    echo "$1=$2" >>$GITHUB_OUTPUT
}

log() {
    echo -e "\033[34m$1\033[0m"
}
