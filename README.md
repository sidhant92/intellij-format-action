# IntelliJ IDEA formatter action

IntelliJ Format Checker with [reviewdog](https://github.com/reviewdog/reviewdog)

Runs the formatter on code to check if the code has been formatted according to standards.

Supports both default IntelliJ formatting and custom format settings

Uses the file:
`.idea/codeStyles/Project.xml` to format the code if this is present or else defaults to IntelliJ formatting.

Example:

<img width="790" alt="Screenshot 2021-12-23 at 2 17 50 AM" src="https://user-images.githubusercontent.com/10743214/147153346-cf1248f0-efab-4f0c-813a-5d2e7b8c1df0.png">

## Inputs

### `file_mask`

Pattern for files to include in the formatting, e.g. `*.java,*.kt`.

Default: `*`.

### `path`

Root path from which files to format are searched recursively. Must be relative to the workspace.

Default: `.`.

### `reporter`

Reporter of reviewdog command [github-pr-check,github-pr-review].
It's same as `-reporter` flag of reviewdog.

Default: `github-pr-review`.

### `filter_mode`

Optional. Filtering mode for the reviewdog command [added,diff_context,file,nofilter].
It's same as `-reporter` flag of reviewdog.

Default: `added`.

### `tool_name`

Tool name to use for reviewdog reporter.

Default: `diff`.


### `fail_on_changes`

Causes the action to fail upon detecting files changed by running the formatter if set to `true`.

Default: `false`.

## Outputs

### `files-changed`
Outputs the list of files which are not formatted properly.

Zero if none changed.

## Example usage

```yaml
jobs:
  intelliJ:
    runs-on: ubuntu-latest
    name: IntelliJ
    steps:
      - name: Checkout
        uses: actions/checkout@v2
      - name: Check IntelliJ Formatting
        uses: sidhant92/intellij-format-action@main
        with:
          tool_name: 'IntelliJ Diff'
          github_token: ${{ secrets.github_token }}
          fail_on_changes: true
          path: '.'
          file_mask: '*.java'
```
