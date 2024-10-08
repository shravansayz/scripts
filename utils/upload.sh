#!/bin/bash

PATTERN=""
FIND_ARGS=("-type" "f")
FFSEND_ARGS=("-fIqy" "--host" "https://de.skysend.ch" "--download-limit" "1000" "--expiry-time" "7d")
FILES=()

if ! command -v ffsend &> /dev/null; then
    echo "ffsend not found. Please install it first."
    exit 1
fi

usage() {
    echo "Usage: $0 (-h | --help) [path]"
    echo "Uploads files from the specified path to the ffsend server (supports globs)."
    echo "Options:"
    echo "  -h, --help    Show this help message"
    exit 1
}

while [[ "$#" -gt 0 ]]; do
    case $1 in
        -h|--help)
            usage
            ;;
        -*)
            echo "Unknown parameter passed: $1"
            usage
            ;;
        *)
            PATTERN="$1"
            ;;
    esac
    shift
done

if [[ -z "$PATTERN" ]]; then
    echo "Error: Path is required."
    usage
fi

for FILE in $(echo $PATTERN); do
    if [[ -f "$FILE" ]]; then
        FILES+=("$FILE")
    fi
done

echo "Uploading ${#FILES[@]} files..."

for FILE in "${FILES[@]}"; do
    echo "$FILE:"
    ffsend upload "${FFSEND_ARGS[@]}" "$FILE"
    echo
done

exit 0
