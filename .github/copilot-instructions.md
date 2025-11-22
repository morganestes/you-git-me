<!-- Copilot / AI agent instructions for the `you-git-me` repo -->
# .github/copilot-instructions.md

Purpose
- This repository is a collection of small, self-contained Git helper commands (each file is a script intended to act as a `git-<command>` subcommand).

Big picture
- Location: top-level files like `git-wtf`, `git-whereami`, `git-makezip`, etc. Each file is an executable script (bash, Ruby, etc.).
- Design: scripts are single-file CLIs invoked directly or installed into `PATH` and used as `git <command>` (e.g. `git wtf`).
- Data flow: scripts call Git plumbing and porcelain commands (e.g. `git rev-parse`, `git for-each-ref`, `git log`, `git diff`) and format/print their results. Some scripts read small config files (example: `git-wtf` reads `.git-wtf`).

Key files & patterns (examples)
- `git-wtf` (Ruby): uses `YAML` config `.git-wtf`, optional color gem `term/ansicolor`, sets global `$debug` flag. Useful example for parsing git refs and formatting output.
- `git-whereami` (bash): minimal script that runs `git rev-parse --abbrev-ref HEAD`.
- `README.md`: short high-level description of the repo purpose.
- `.github/instructions/snyk_rules.instructions.md`: project policy requiring a Snyk code scan for newly generated first-party code. Always follow that when creating/modifying code.

Developer / agent workflows
- Running scripts locally:
  - Make executable and run directly: `chmod +x git-whereami && ./git-whereami`
  - Install into PATH (macOS example): `ln -s "$(pwd)/git-whereami" /usr/local/bin/git-whereami` then invoke as `git whereami`.
- Ruby scripts: these assume system Ruby + gems. If a script `require`s a gem (e.g. `term/ansicolor`), install it with `gem install term-ansicolor` or use your Ruby environment manager (`rbenv`, `chruby`, etc.). There is no `Gemfile` or Bundler config in the repo.
- Editing rules for AI-generated changes:
  - Preserve the language and the shebang line (first line) of the script.
  - Keep changes minimal and focused — these scripts are small single-file utilities.
  - Maintain executable bit; if you add or modify a script file, ensure it is still executable (`chmod +x`).
  - If adding a new script, follow the `git-<name>` naming convention and add a one-line entry in `README.md`.
  - Ignore files inside the `.history` folder (these are local-only edit history files, not part of the repo).

Project-specific conventions and pitfalls
- Naming: scripts are named `git-<subcommand>` to act as Git subcommands.
- Config files: `git-wtf` expects `.git-wtf` YAML in the repo root; other scripts may use similar local config files — search the script for `CONFIG` or YAML loads.
- No central package manager: languages mix (bash, Ruby, possibly others). Do not assume `npm`, `pip`, or bundler unless you add appropriate manifests.
- Output parsing: scripts rely on exact `git` output formats (for-each-ref, pretty log formats). Be conservative when changing parsing logic.

Security / scanning
- Follow the repository Snyk instruction at `.github/instructions/snyk_rules.instructions.md`:
  - Run Snyk code scan for any new first-party code in supported languages.
  - If Snyk reports issues for newly added/modified code, attempt to fix them and re-scan.

Testing & CI
- There are no automated tests or CI config in this repo. Validate changes by running the script manually against a Git repo.
- Example validation steps:
  - `chmod +x git-wtf` (if new)
  - Run in a local Git repo: `./git-wtf` or `git wtf` (if installed into PATH)

Commit / PR guidance for AI-generated changes
- Keep commits small and focused: one script per feature/bugfix.
- Update `README.md` with any new subcommand and short usage example.
- Note any required runtime dependency (gems, external commands) in the PR description.

If anything is unclear
- Ask a human for context about intended behavior before making non-trivial parsing or UX changes.
- After making changes, request that an actual maintainer run the modified scripts in a representative Git repository and confirm behavior.

-- End of instructions --
