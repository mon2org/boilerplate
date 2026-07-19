#!/bin/sh
set -eu

printf '%s\n' "[devcontainer] on-create"

if command -v mise >/dev/null 2>&1; then
  mise --version
fi