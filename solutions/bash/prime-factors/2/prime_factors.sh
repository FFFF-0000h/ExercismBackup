#!/usr/bin/env bash

prime_factors() {
  local n=$1
  local factor=2
  local output=""
  while [ $n -gt 1 ]; do
    while [ $(( n % factor )) -eq 0 ]; do
      output+="$factor "
      n=$(( n / factor ))
    done
    factor=$(( factor + 1 ))
  done
  echo "${output%" "}"
}

main() {
  if [ -z "$1" ] || [ "$1" -lt 2 ]; then
    exit 0
  fi

  prime_factors "$1"
}

main "$@"