#!/bin/bash

if [[ -z "$STEAMDIR" ]]; then
    >&2 echo "error: STEAMDIR not set"
    exit 1
fi

STEAMCMD="$STEAMDIR/steamcmd.sh"

if ! [[ -f "$STEAMCMD" ]]; then
    >&2 echo "error: entrypoint not found: $STEAMCMD"
    exit 1
fi

cd "$STEAMDIR"
exec "$STEAMCMD" $@
