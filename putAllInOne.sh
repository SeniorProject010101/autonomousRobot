#!/usr/bin/env bash


#
#   NOTE -- YO MAKE SURE YOU KEEP THIS IN THE SOURCE ROOT AND DON'T UPDATE ANYTHING IN AUTONOMOUSROBOT FOLDER
#   SIMPLY RUN THIS TO PUSH IT TO MAIN REPO
#
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
MAIN="$ROOT/autonomousRobot"
GITHUB_ORG="git@github.com:SeniorProject010101"

REPOS=(
    "mobile-app"
    "robot"
    "computer-vision"
    "core-connection"
)

if [ ! -d "$MAIN/.git" ]; then
    echo "$MAIN is not a git repository"
    exit 1
fi

echo "Combining repositories into: $MAIN"
echo

SYNCED=()
for REPO in "${REPOS[@]}"; do
    SOURCE="$ROOT/$REPO"
    DEST="$MAIN/$REPO"

    # Clone the component repo next to the monorepo if it isn't there yet
    if [ ! -d "$SOURCE/.git" ]; then
        echo "$REPO not found locally, cloning..."
        if ! git clone -q "$GITHUB_ORG/$REPO.git" "$SOURCE"; then
            echo "Could not clone $REPO, skipping"
            echo
            continue
        fi
    fi

    echo "Syncing $REPO..."

    # Start from an empty folder so files removed upstream are removed here too
    rm -rf "$DEST"
    mkdir -p "$DEST"

    # Copy the files git knows about (skips .git, build output, anything ignored).
    # The existence check skips files that are tracked but deleted in the working tree.
    (
        cd "$SOURCE"
        git ls-files -z --cached --others --exclude-standard \
            | while IFS= read -r -d '' f; do [ -e "$f" ] && printf '%s\0' "$f"; done \
            | tar --null -T - -cf -
    ) | tar -xf - -C "$DEST"

    # Never leave a nested repo behind (e.g. a submodule's .git file)
    find "$DEST" -name .git -prune -exec rm -rf {} +

    SHA="$(git -C "$SOURCE" rev-parse --short HEAD 2>/dev/null || echo "no-commits")"
    DIRTY=""
    [ -n "$(git -C "$SOURCE" status --porcelain)" ] && DIRTY=" +uncommitted"
    SYNCED+=("$REPO @ $SHA$DIRTY")

    echo "$REPO synced ($SHA$DIRTY)"
    echo
done

cd "$MAIN"
git add -A

if git diff --cached --quiet; then
    echo "Nothing changed, nothing to commit."
    exit 0
fi

echo "Changes:"
git diff --cached --stat | tail -n 20
echo

MESSAGE="${1:-Sync components $(date '+%Y-%m-%d %H:%M')}"
BODY="$(printf '%s\n' "${SYNCED[@]}")"

git commit -q -m "$MESSAGE" -m "$BODY"
echo "Pushing..."
git push -u origin HEAD

echo
echo "Done!"
