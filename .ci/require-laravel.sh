#!/usr/bin/env sh

## Script to require a given Laravel version, e.g. "7.16.1"
##
## The version number is passed to composer as-is, so any syntax supported by
## composer is also supported by this script (e.g. "^7", "7.*" etc...)
##
## This script also supports Laravel's current version's development branch by
## passing "development" instead of a version number or the unstable development
## branch by passing "development-unstable"

set -e

if [ $# -eq 0 ]; then
    printf "Error: No Laravel version given\n\n"
    printf "Usage:\n"
    printf "  $ %s <version>\n\n" "$0"
    printf "Examples:\n"
    printf "  $ %s development\n" "$0"
    printf "  $ %s development-unstable\n" "$0"
    printf "  $ %s 7.*\n" "$0"
    printf "  $ %s 5.3.0\n" "$0"

    exit 64
fi

LARAVEL_VERSION=$1

if [ "$LARAVEL_VERSION" = "development" ]; then
    composer require "laravel/framework:7.x-dev as 7" --no-update
elif [ "$LARAVEL_VERSION" = "development-unstable" ]; then
    composer require "laravel/framework:dev-master as 7" --no-update
else
    composer require "laravel/framework:${LARAVEL_VERSION}" --no-update
fi
