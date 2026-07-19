#!/bin/sh
set -eu

printf '%s\n' "[devcontainer] update-content"

if [ -f .mise.toml ] || [ -f .tool-versions ]; then
  mise install
fi