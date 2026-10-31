#!/usr/bin/env bash
# Calcula o STATUS pelo codigo de saida dos comandos. O modelo nunca decide isso.
# Ajuste CMDS ao projeto. No fish, chame com: bash strata_verify.sh
set -u
CMDS=("cargo build" "cargo test" "cargo clippy -- -D warnings")
status="VERIFIED"; detail=""
if [ "${#CMDS[@]}" -eq 0 ]; then
  status="UNVERIFIED"
fi
for c in "${CMDS[@]}"; do
  if ! eval "$c" >/tmp/strata_out.log 2>&1; then
    status="FAIL"; detail="$c"; break
  fi
done
printf '    [STRATA_STATUS]\n    - STATUS: %s\n    - Failed: %s\n' "$status" "${detail:-none}"
[ "$status" = "VERIFIED" ]
