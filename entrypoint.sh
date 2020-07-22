#!/bin/bash

# Git reference
ref="$1"

# Prefix for branches/tags
prefix="${2:-"v"}"


ref2version () {
    sed -nE -e 's/(^|.*\/)'"$prefix"'([0-9]+).*/\2/p'
}

major_current="$(ref2version <<< "$ref")"
if [ -n "$major_current" ]; then
    echo "::set-output name=major_current::$major_current"
else
    echo "::warning ::Could not determine current major version, using 0"
    echo "::set-output name=major_current::0"
fi

major_latest="$( (
        git branch --list -r "*/$prefix*"
        git tag --list "*/$prefix*"
    ) | ref2version | sort -h | tail -1)"
if [ -n "$major_current" ]; then
    echo "::set-output name=major_latest::$major_latest"
else
    echo "::warning ::Could not determine latest major version, using 0"
    echo "::set-output name=major_latest::0"
fi

