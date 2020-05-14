#!/bin/zsh
set -x

source $(pwd)/scripts/exports.sh
source $(pwd)/scripts/functions.sh

function main() {
  readData
  create_dir
  create_cert
  move_nginx_block
  edit_nginx_block
  move_nginx_block_to_infra
}

main
