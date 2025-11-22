# Completions for you-git-me

This folder contains centralized shell completion helpers for the `git-<command>` scripts in this repository.

Install (one-time):

- Bash (add to `~/.bashrc` or `~/.bash_profile`):

```bash
echo 'source "$(pwd)/completions/git-completions.bash"' >> ~/.bashrc
```

- Zsh (add to your `fpath` and initialize `compinit` in `~/.zshrc`):

```bash
echo 'fpath=("$(pwd)/completions" $fpath)' >> ~/.zshrc
echo 'autoload -U compinit && compinit' >> ~/.zshrc
```

Or, source directly for the current session:

```bash
# Bash
source ./completions/git-completions.bash

# Zsh
fpath=(./completions $fpath); autoload -U compinit && compinit
```

Notes:

- The completion scripts are centralized so individual `git-<command>` scripts do not emit their own completion text.
- If you move the repo, update the `source` / `fpath` paths above accordingly.
