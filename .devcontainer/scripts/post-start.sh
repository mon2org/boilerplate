#!/bin/sh
set -eu

printf '%s\n' "[devcontainer] post-start"

if command -v mise >/dev/null 2>&1; then
  mise doctor >/dev/null 2>&1 || true
fi