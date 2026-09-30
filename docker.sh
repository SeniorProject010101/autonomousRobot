#!/usr/bin/env bash
# Usage: ./docker.sh

set -e
cd "$(dirname "$0")"
docker compose up -d --build
if [ "$1" = "build" ]; then
  docker compose exec ros bash -lc "source /opt/ros/jazzy/setup.bash && bash build.sh"
else
  docker compose exec ros bash
fi
