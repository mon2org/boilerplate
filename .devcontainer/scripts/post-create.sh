#!/bin/sh
set -eu

printf '%s\n' "[devcontainer] post-create"

if [ -f .mise.toml ] || [ -f .tool-versions ]; then
  mise install
fi