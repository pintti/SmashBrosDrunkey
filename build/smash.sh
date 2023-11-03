#!/bin/sh
echo -ne '\033c\033]0;Smash\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/smash.x86_64" "$@"
