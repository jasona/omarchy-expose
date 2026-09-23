# Repository guidance

## Pull requests from contributors

- In the PR description, include `AI models used: None` if no AI helped create
  or edit the contribution. Otherwise, list every AI model used to create or
  edit the code, tests, or PR text with its most specific available name and
  version, for example
  `AI models used: GPT-6 Astra, Claude Sonnet 4.5`.
- Routine automated review bots do not need to be listed.
- This requirement applies to contributors other than the repository owner.
  Do not guess a model version; check the tool's model setting before opening
  the PR.
- If the tool exposes a reasoning level or effort setting, include it for each
  listed model in the PR description, for example
  `Reasoning levels: GPT-6 Astra: high`. If the tool does not expose it, say
  `Reasoning levels: Unavailable (not exposed by tool)`. Do not guess. An
  unavailable or missing reasoning level must not block the PR.

## Release workflow

- Treat `manifest.json` as the release source of truth and bump its semantic
  version for every published release.
- Validate with `./validate`. It runs the QML unit tests in `tests/`,
  `qmllint`, shell syntax checks for the helper scripts, and
  `omarchy plugin validate .`. The `qmltestrunner` and `qmllint` on PATH are
  Qt 5 builds that silently do nothing useful; the script calls the Qt 6
  binaries in `/usr/lib/qt6/bin` directly.
- The README demo is a GitHub release asset, not a tracked file, so clones stay
  small. Attach replacement media to a release and update the README link.
- Keep `https://github.com/kristofferR/omarchy-expose.git` published in the
  Okomart catalog at `brianblakely/omarchy-plugins`. When adding or changing
  its catalog entry, update `plugins.txt`, regenerate the marker-owned README
  table, validate the catalog, and submit the change through the
  `kristofferR/omarchy-plugins` fork.
