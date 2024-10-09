#!/bin/bash
if [[ -z "$GAMEDIR" ]]; then
    >&2 echo "error: GAMEDIR not set"
    exit 1
fi


if ! (type jq > /dev/null); then
    >&2 echo "error: jq is required"
    exit 1
fi

VERSION_FILE="${GAMEDIR}/Engine/Binaries/Linux/FactoryServer-Linux-Shipping.version"
if ! [[ -f "$VERSION_FILE" ]]; then
    >&2 echo "error: version file not found: ${VERSIONP_FILE}"
    exit 1
fi

VERSION_TYPE=${VERSION_TYPE:-semver}

case "$VERSION_TYPE" in
    semver)
        jq -r '"\(.MajorVersion).\(.MinorVersion).\(.PatchVersion)"' "$VERSION_FILE"
        ;;
    buildnum)
        jq -r '.BuildId' "$VERSION_FILE"
        ;;
    *)
        >&2 echo "error: unknown version type requested: ${VERSION_TYPE}"
        exit 1
        ;;
esac
