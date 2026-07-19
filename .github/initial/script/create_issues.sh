#!/usr/bin/env bash
set -e

if [ ! -d .github/initial ]; then
  echo ".github/initial not found. Skipping issue creation."
  exit 0
fi

repo_full_name="${GITHUB_REPOSITORY}"
repo_owner="${GITHUB_REPOSITORY_OWNER}"
repo_name="${GITHUB_REPOSITORY#*/}"
repo_url="${GITHUB_SERVER_URL}/${GITHUB_REPOSITORY}"

escape_sed_replacement() {
  printf '%s' "$1" | sed -e 's/[\\/&]/\\\\&/g'
}

render_template() {
  local template_path="$1"
  local output_path="$2"

  sed \
    -e "s|{{REPO_FULL_NAME}}|$(escape_sed_replacement "${repo_full_name}")|g" \
    -e "s|{{REPO_OWNER}}|$(escape_sed_replacement "${repo_owner}")|g" \
    -e "s|{{REPO_NAME}}|$(escape_sed_replacement "${repo_name}")|g" \
    -e "s|{{REPO_URL}}|$(escape_sed_replacement "${repo_url}")|g" \
    -e "s|{{DEFAULT_BRANCH}}|$(escape_sed_replacement "${DEFAULT_BRANCH}")|g" \
    "${template_path}" > "${output_path}"
}

create_issue_from_template() {
  local template="$1"
  local rendered
  local title
  local body_file

  rendered=$(mktemp)
  render_template "${template}" "${rendered}"

  title=$(head -n 1 "${rendered}")
  body_file=$(mktemp)
  tail -n +2 "${rendered}" > "${body_file}"

  if [ -z "${title}" ]; then
    title=$(basename "${template}" -issue-template.md)
  fi

  echo "Creating issue from ${template}"
  echo "Title: ${title}"
  gh issue create --title "${title}" --body-file "${body_file}"

  issue_count=$((issue_count + 1))
  rm -f "${body_file}" "${rendered}"
}

issue_count=0

WELCOME_template=".github/initial/WELCOME-issue-template.md"
if [ -f "${WELCOME_template}" ]; then
  create_issue_from_template "${WELCOME_template}"
  echo "WELCOME issue created first."
else
  echo "${WELCOME_template} not found. Skipping prioritized WELCOME issue."
fi

while IFS= read -r -d '' template; do
  if [ "${template}" = "${WELCOME_template}" ]; then
    continue
  fi
  create_issue_from_template "${template}"
done < <(find .github/initial -type f -name '*-issue-template.md' -print0 | sort -z)

echo "Created issues: ${issue_count}"