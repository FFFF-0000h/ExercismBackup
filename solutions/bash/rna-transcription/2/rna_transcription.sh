#!/bin/bash

DNA="CGTA"
RNA="GCAU"

validate() {
  DNA_STRAND="$1"

  if [[ ! "$DNA_STRAND" =~ ^[$DNA]*$ ]]; then
    echo "Invalid nucleotide detected."
    exit 1
  fi
}

DNA_STRAND="$1"

# Handle empty input - return empty string and exit successfully
if [[ -z "$DNA_STRAND" ]]; then
  echo ""
  exit 0
fi

validate "$DNA_STRAND"
echo "$DNA_STRAND" | tr "$DNA" "$RNA"