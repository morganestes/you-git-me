#!/usr/bin/env bash
# Bash completion for you-git-me helper scripts
# Source this file in your shell to enable completions for the git-* helpers.

_ygm__refs() {
    # return branches, tags and remotes (remote/* stripped)
    if command -v git >/dev/null 2>&1; then
        git for-each-ref --format='%(refname:short)' refs/heads refs/tags refs/remotes 2>/dev/null |
            sed 's#^remotes/##' | sort -u
    fi
}

_ygm__files() {
    if command -v git >/dev/null 2>&1; then
        git ls-files 2>/dev/null
    fi
}

_ygm__common_opts="--help -h --completion"

# git-getonefile: complete tracked filenames
_git_getonefile() {
    local cur="${COMP_WORDS[COMP_CWORD]}"
    COMPREPLY=()
    if [[ ${cur} == -* ]]; then
        mapfile -t COMPREPLY < <(compgen -W "${_ygm__common_opts}" -- "$cur")
        return 0
    fi
    # Read file list into an array to avoid unwanted word-splitting
    local files
    mapfile -t files < <(_ygm__files)
    if (( ${#files[@]} )); then
        mapfile -t COMPREPLY < <(compgen -W "${files[*]}" -- "$cur")
    else
        COMPREPLY=()
    fi
}
complete -F _git_getonefile git-getonefile

# git-diffmod: complete commit-ish refs for both args
_git_diffmod() {
    local cur="${COMP_WORDS[COMP_CWORD]}"
    COMPREPLY=()
    if [[ ${cur} == -* ]]; then
        mapfile -t COMPREPLY < <(compgen -W "${_ygm__common_opts}" -- "$cur")
        return 0
    fi
    local refs
    mapfile -t refs < <(_ygm__refs)
    COMPREPLY=()
    if (( ${#refs[@]} )); then
        mapfile -t COMPREPLY < <(compgen -W "${refs[*]}" -- "$cur")
    fi
}
complete -F _git_diffmod git-diffmod

# git-mainer: complete branch names and remotes; prefer master/main first
_git_mainer() {
    local cur="${COMP_WORDS[COMP_CWORD]}"
    COMPREPLY=()
    if [[ ${cur} == -* ]]; then
        mapfile -t COMPREPLY < <(compgen -W "${_ygm__common_opts}" -- "$cur")
        return 0
    fi
    local candidates
    mapfile -t candidates < <(echo "master" "main"; _ygm__refs)
    mapfile -t COMPREPLY < <(compgen -W "${candidates[*]}" -- "$cur")
}
complete -F _git_mainer git-mainer

# git-branch-archive: complete remotes for upstream arg
_git_branch_archive() {
    local cur="${COMP_WORDS[COMP_CWORD]}"
    COMPREPLY=()
    if [[ ${cur} == -* ]]; then
        mapfile -t COMPREPLY < <(compgen -W "--help -h" -- "$cur")
        return 0
    fi
    if command -v git >/dev/null 2>&1; then
        local remotes
        mapfile -t remotes < <(git remote 2>/dev/null)
        mapfile -t COMPREPLY < <(compgen -W "${remotes[*]}" -- "$cur")
    fi
}
complete -F _git_branch_archive git-branch-archive

# git-localiq-lite-upstream: options only
_git_localiq_lite_upstream() {
    local cur="${COMP_WORDS[COMP_CWORD]}"
    COMPREPLY=()
    if [[ ${cur} == -* ]]; then
        mapfile -t COMPREPLY < <(compgen -W "--site -s --branch -b --help -h" -- "$cur")
    fi
}
complete -F _git_localiq_lite_upstream git-localiq-lite-upstream

# git-makezip: options only
_git_makezip() {
    local cur="${COMP_WORDS[COMP_CWORD]}"
    if [[ ${cur} == -* ]]; then
        mapfile -t COMPREPLY < <(compgen -W "${_ygm__common_opts}" -- "$cur")
    fi
}
complete -F _git_makezip git-makezip

# git-patch: options only
_git_patch() {
    local cur="${COMP_WORDS[COMP_CWORD]}"
    if [[ ${cur} == -* ]]; then
        mapfile -t COMPREPLY < <(compgen -W "${_ygm__common_opts}" -- "$cur")
    fi
}
complete -F _git_patch git-patch

# git-remote-cleanup: options only
_git_remote_cleanup() {
    local cur="${COMP_WORDS[COMP_CWORD]}"
    if [[ ${cur} == -* ]]; then
        mapfile -t COMPREPLY < <(compgen -W "${_ygm__common_opts}" -- "$cur")
    fi
}
complete -F _git_remote_cleanup git-remote-cleanup

# git-rm-cached: options only
_git_rm_cached() {
    local cur="${COMP_WORDS[COMP_CWORD]}"
    if [[ ${cur} == -* ]]; then
        mapfile -t COMPREPLY < <(compgen -W "${_ygm__common_opts}" -- "$cur")
    fi
}
complete -F _git_rm_cached git-rm-cached

# git-rm-merged: include --remote option
_git_rm_merged() {
    local cur="${COMP_WORDS[COMP_CWORD]}"
    if [[ ${cur} == -* ]]; then
        mapfile -t COMPREPLY < <(compgen -W "--remote --help -h --completion" -- "$cur")
    fi
}
complete -F _git_rm_merged git-rm-merged

# git-whereami: options only
_git_whereami() {
    local cur="${COMP_WORDS[COMP_CWORD]}"
    if [[ ${cur} == -* ]]; then
        mapfile -t COMPREPLY < <(compgen -W "${_ygm__common_opts}" -- "$cur")
    fi
}
complete -F _git_whereami git-whereami

# git-wtf: options only
_git_wtf() {
    local cur="${COMP_WORDS[COMP_CWORD]}"
    if [[ ${cur} == -* ]]; then
        mapfile -t COMPREPLY < <(compgen -W "${_ygm__common_opts}" -- "$cur")
    fi
}
complete -F _git_wtf git-wtf

echo "you-git-me: bash completions registered (source this file to enable)" >&2
