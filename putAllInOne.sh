#!/usr/bin/env bash


### Tamim Dostyar

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
)

if [ ! -d "$MAIN/.git" ]; then
    echo "$MAIN is not a git repository"
    exit 1
fi

cd "$MAIN"

# subtree refuses to run on a dirty tree, and we don't want to sweep up stray edits
if [ -n "$(git status --porcelain)" ]; then
    echo "$MAIN has uncommitted changes, commit or stash them first"
    exit 1
fi

echo "Combining repositories into: $MAIN"
echo

for REPO in "${REPOS[@]}"; do
    URL="$GITHUB_ORG/$REPO.git"

    # Use whatever the default branch is on GitHub (some repos are main, some master)
    BRANCH="$(git ls-remote --symref "$URL" HEAD 2>/dev/null \
        | awk '/^ref:/ { sub("refs/heads/", "", $2); print $2 }')"
    if [ -z "$BRANCH" ]; then
        echo "Could not reach $REPO (or it has no commits), skipping"
        echo
        continue
    fi

    if git log --grep="^git-subtree-dir: $REPO\$" --format=%H -1 | grep -q .; then
        echo "Pulling $REPO ($BRANCH)..."
        git subtree pull -q --prefix="$REPO" "$URL" "$BRANCH" \
            -m "Merge $REPO ($BRANCH) into main repo"
    else
        # First time: drop the old file-copy snapshot so subtree can take over the folder
        if [ -e "$REPO" ]; then
            echo "Replacing old $REPO snapshot with full history..."
            git rm -r -q "$REPO"
            git commit -q -m "Remove $REPO snapshot before importing its history"
        fi
        echo "Importing $REPO ($BRANCH) with history..."
        git subtree add -q --prefix="$REPO" "$URL" "$BRANCH" \
            -m "Import $REPO ($BRANCH) with full history"
    fi

    echo "$REPO synced"
    echo
done

if [ -z "$(git log '@{u}..HEAD' --oneline 2>/dev/null || echo new)" ]; then
    echo "Nothing changed, nothing to push."
    exit 0
fi

echo "Pushing..."
git push -u origin HEAD

echo
echo "Done!"
