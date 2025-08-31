#!/usr/bin/env bash
set -Eeuo pipefail

init() {
    BACKUP_DIR="backup"
    NOW_UTC="$(date -Iminutes -u)"  # cryptic flags for busybox compatibility
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

    step "Cleaning up..."
    flyctl ssh console --command "rm -r '${BACKUP_DIR}'"

    exit $?
}

main
