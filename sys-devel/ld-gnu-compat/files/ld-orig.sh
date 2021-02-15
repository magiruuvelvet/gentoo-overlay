#!/bin/bash

ld="$(basename "$0")"
ld="${ld::-1}"
exec "/sucks/gnu/bin/$ld" "$@"
