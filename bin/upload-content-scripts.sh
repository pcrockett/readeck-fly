#!/usr/bin/env bash
set -Eeuo pipefail

exec_server() {
    flyctl ssh console --command "${*}"
}

main() {
    for file in content-scripts/*.js;
    do
        echo "uploading ${file}..."
        file_name="$(basename "${file}")"
        exec_server "tee '/readeck/data/content-scripts/${file_name}'" < "${file}"
    done
    exit $?
}

main
