#!/bin/bash
im=$(fcitx5-remote -n 2>/dev/null || echo "")
case "$im" in
  *mozc*|*anthy*) echo "JP" ;;
  *pinyin*)       echo "CN" ;;
  *hangul*)       echo "KR" ;;
  *)              echo "EN" ;;
esac
