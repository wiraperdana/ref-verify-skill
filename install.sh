#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
skill_dir="$repo_dir/skills/ref-verify"

for target_dir in "$HOME/.claude/skills" "$HOME/.agents/skills"; do
  mkdir -p "$target_dir"
  target="$target_dir/ref-verify"
  if [[ -e "$target" || -L "$target" ]]; then
    if [[ -L "$target" && "$(readlink "$target")" == "$skill_dir" ]]; then
      printf 'Sudah terpasang: %s\n' "$target"
      continue
    fi
    if [[ -L "$target" && ! -e "$target" ]]; then
      rm "$target"
      printf 'Symlink rusak dihapus: %s\n' "$target"
    else
      printf 'Target sudah ada, periksa manual: %s\n' "$target" >&2
      exit 1
    fi
  fi
  ln -s "$skill_dir" "$target"
  printf 'Terpasang: %s -> %s\n' "$target" "$skill_dir"
done
