#!/usr/bin/env bash
set -e

template=".github/initial/README-md-template.md"
output=".github/README.md"

if [ ! -f "${template}" ]; then
  echo "${template} not found. Skipping README generation."
  exit 0
fi

repo_full_name="${GITHUB_REPOSITORY}"
repo_owner="${GITHUB_REPOSITORY_OWNER}"
repo_name="${GITHUB_REPOSITORY#*/}"
repo_url="${GITHUB_SERVER_URL}/${GITHUB_REPOSITORY}"

escape_sed_replacement() {
  printf '%s' "$1" | sed -e 's/[\\/&]/\\\\&/g'
}

sed \
  -e "s|{{REPO_FULL_NAME}}|$(escape_sed_replacement "${repo_full_name}")|g" \
  -e "s|{{REPO_OWNER}}|$(escape_sed_replacement "${repo_owner}")|g" \
  -e "s|{{REPO_NAME}}|$(escape_sed_replacement "${repo_name}")|g" \
  -e "s|{{REPO_URL}}|$(escape_sed_replacement "${repo_url}")|g" \
  -e "s|{{DEFAULT_BRANCH}}|$(escape_sed_replacement "${DEFAULT_BRANCH}")|g" \
  "${template}" > "${output}"

echo "Generated ${output}"