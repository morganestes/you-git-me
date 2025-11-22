# you-git-me
A collection of custom Git commands I use.

Completions
-----------

This repository provides centralized shell completions for the `git-<command>` scripts in `completions/`.

Quick install:

- Bash (add to `~/.bashrc` or `~/.bash_profile`):

```bash
echo 'source "$(pwd)/completions/git-completions.bash"' >> ~/.bashrc
```

- Zsh (add to your `fpath` and initialize `compinit` in `~/.zshrc`):

```bash
echo 'fpath=("$(pwd)/completions" $fpath)' >> ~/.zshrc
echo 'autoload -U compinit && compinit' >> ~/.zshrc
```

For more details and alternatives (sourcing for the current session, installing to system completion directories), see `completions/README.md`.

