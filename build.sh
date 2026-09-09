#!/usr/bin/env bash
set -euo pipefail

cd -- "$(dirname -- "${BASH_SOURCE[0]}")"

if (($# == 0)); then
  set -- report notebook
fi

for target in "$@"; do
  case "$target" in
    report|notebook) ;;
    *) printf '用法：%s [report|notebook] ...\n' "$0" >&2; exit 1 ;;
  esac
done

for dependency in typst pdfinfo awk; do
  command -v "$dependency" >/dev/null || {
    printf '缺少命令：%s\n' "$dependency" >&2
    exit 1
  }
done

for target in "$@"; do
  typst compile "$target.typ" "$target.pdf"
  page_count=$(LC_ALL=C pdfinfo "$target.pdf" | awk '/^Pages:/ {print $2}')
  [[ "$page_count" =~ ^[0-9]+$ ]] && ((page_count >= 4)) || {
    printf '无法确定 %s.pdf 的页数\n' "$target" >&2
    exit 1
  }

  first_inner=2
  if [[ "$target" == notebook ]]; then
    first_inner=3
  fi
  last_inner=$((page_count - 1))

  # 从同一排版选择物理页，保留内页页码、目录及装订补页。
  typst compile --no-pdf-tags --pages "1" "$target.typ" "$target-cover.pdf"
  typst compile --no-pdf-tags --pages "$first_inner-$last_inner" "$target.typ" "$target-inner.pdf"
  printf '已生成 %s.pdf、%s-cover.pdf、%s-inner.pdf\n' "$target" "$target" "$target"
done
