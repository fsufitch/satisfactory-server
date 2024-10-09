#!/bin/bash
SCRIPT_DIR=$(cd -- "$(dirname "${BASH_SOURCE[0]}")" && pwd)

CTOOL=$(type -p podman || type -p docker)
if [[ -z "$CTOOL" ]]; then
    >&2 echo "error: no container tool found (looked for podman, docker)"
    exit 1
fi

REPOSITORY=${REPOSITORY:-docker.io/fsufitch/satisfactory-server}
VERSION=${VERSION:-latest}

(
    set -ex
    "$CTOOL" build -t "${REPOSITORY}:${VERSION}" "$SCRIPT_DIR"
)
