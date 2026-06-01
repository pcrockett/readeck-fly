#!/usr/bin/env bash
set -euo pipefail

init() {
  BACKUP_DIR="backup"
  NOW_UTC="$(date -Iminutes -u)" # cryptic flags for busybox compatibility
  BACKUP_ARCHIVE="${BACKUP_DIR}/${NOW_UTC}.zip"
}

step() {
  echo "--> $*"
}

main() {
  init

  local backup_commands="
mkdir -p '${BACKUP_DIR}'
readeck export -config config.toml '${BACKUP_ARCHIVE}'
exit
"
  step "Running export..."
  echo "${backup_commands}" | flyctl ssh console

  step "Downloading archive..."
  flyctl ssh sftp get "${BACKUP_ARCHIVE}"
  mkdir -p backup
  mv "${NOW_UTC}.zip" backup

  pushd backup &>/dev/null
  rm -rf contents.new # in case there's a left-over file from a previous error
  unzip "${NOW_UTC}.zip" -d contents.new
  rm -rf contents
  mv contents.new contents
  rm "${NOW_UTC}.zip"

  step "Cleaning up..."
  popd &>/dev/null
  flyctl ssh console --command "rm -r '${BACKUP_DIR}'"

  exit $?
}

main
