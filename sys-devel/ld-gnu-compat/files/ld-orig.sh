#!/bin/bash

ld="$(basename "$0")"
ld="${ld::-1}"
exec "/opt/gnu/bin/$ld" "$@"
