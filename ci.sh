#!/bin/bash
set -e -o pipefail

SCRIPT_DIR=$(cd -- "$(dirname "${BASH_SOURCE[0]}")" && pwd)

CTOOL=$(type -p podman || type -p docker)
if [[ -z "$CTOOL" ]]; then
    >&2 echo "error: no container tool found (looked for podman, docker)"
    exit 1
fi

BUILD_REPOSITORY=${BUILD_REPOSITORY:-docker.io/fsufitch/satisfactory-server}
BUILD_VERSION=${BUILD_VERSION:-latest}

BUILD_TAG="${BUILD_REPOSITORY}:${BUILD_VERSION}"

(set -ex && "$CTOOL" build -t "${BUILD_TAG}" "${SCRIPT_DIR}")

if [[ -n "$ENABLE_PUSH" ]]; then
    (set -ex && "$CTOOL" push "${BUILD_TAG}")
fi


if [[ -z "$SKIP_TAGGING" ]]; then
    if [[ "$BUILD_VERSION" != "latest" ]]; then
        LATEST_TAG="${BUILD_REPOSITORY}:latest"
        (set -ex && "$CTOOL" tag "$BUILD_TAG" "$LATEST_TAG")

        if [[ -n "$ENABLE_PUSH" ]]; then
            (set -ex && "$CTOOL" push "${LATEST_TAG}")
        fi
    fi

    SEMVER_VERSION=$("$CTOOL" run --rm --env VERSION_TYPE=semver "${BUILD_TAG}" get-satisfactory-version )
    SEMVER_TAG="${BUILD_REPOSITORY}:${SEMVER_VERSION}"
    (set -ex && "$CTOOL" tag "$BUILD_TAG" "$SEMVER_TAG")

    if [[ -n "$ENABLE_PUSH" ]]; then
        (set -ex && "$CTOOL" push "${SEMVER_TAG}")
    fi

    BUILDNUM_VERSION=$("$CTOOL" run --rm --env VERSION_TYPE=buildnum "${BUILD_TAG}" get-satisfactory-version )
    BUILDNUM_TAG="${BUILD_REPOSITORY}:${BUILDNUM_VERSION}"
    (set -ex && "$CTOOL" tag "$BUILD_TAG" "$BUILDNUM_TAG")

    if [[ -n "$ENABLE_PUSH" ]]; then
        (set -ex && "$CTOOL" push "${BUILDNUM_TAG}")
    fi
fi