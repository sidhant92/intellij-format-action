#!/bin/bash

echo "Running check"

export REVIEWDOG_GITHUB_API_TOKEN="${INPUT_GITHUB_TOKEN}"

base_path=${INPUT_PATH}
include_pattern=${INPUT_FILE_MASK}
workspace="/github/workspace"

cd "$workspace/$base_path" || exit 2

code_style_path="$workspace/.idea/codeStyles/Project.xml"

if test -f $code_style_path;
  then
    echo "Code Style File Found"
    /opt/idea/bin/format.sh -s $code_style_path -m $include_pattern -r .
  else
    echo "Using Default Code Style"
    /opt/idea/bin/format.sh -m $include_pattern -r .
fi

TMPFILE=$(mktemp)
git diff >"${TMPFILE}"
git stash -u && git stash drop
reviewdog -f=diff -f.diff.strip=1 \
  -name="${INPUT_TOOL_NAME}" \
  -reporter="${INPUT_REPORTER:-github-pr-review}" \
  -filter-mode="${INPUT_FILTER_MODE:-added}" \
  -fail-on-error="${INPUT_FAIL_ON_CHANGES:-false}" < "${TMPFILE}"
