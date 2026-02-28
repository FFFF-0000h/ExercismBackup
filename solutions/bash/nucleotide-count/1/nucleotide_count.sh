#!/usr/bin/env bash
main() {
  if (($# > 1)); then
    exit 1
  fi

  if [[ "$1" =~ [^ACGT] ]]; then
    echo "Invalid nucleotide in strand"
    exit 1
  fi

  words="ACGT"

  for ((i = 0; i < ${#words}; i++)); do
    char="${words:i:1}"
    echo "$char: $(echo "$1" | grep -o "$char" | wc -l)"
  done

}
main "$@"
