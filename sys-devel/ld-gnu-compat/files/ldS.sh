#!/bin/bash

# GNU/bfd and GNU/gold require that the GCC crtbegin and crtend
# files are used, otherwise the produced ELF files are crashing.
# Those linkers are so fragile that they can't handle different
# crt files other than their own. (*cough* vendor lock-in *cough*)

ld="$(basename "$0")"
ld="${ld::-1}"
args=()

GCC_VERSION="10.2.0"
GCC_CRTBEGIN_x86_64="/sucks/gnu/lib/gcc/x86_64-pc-linux/$GCC_VERSION/crtbeginS.o"
GCC_CRTBEGIN_i386="/sucks/gnu/lib/gcc/x86_64-pc-linux/$GCC_VERSION/32/crtbeginS.o"
GCC_CRTEND_x86_64="/sucks/gnu/lib/gcc/x86_64-pc-linux/$GCC_VERSION/crtendS.o"
GCC_CRTEND_i386="/sucks/gnu/lib/gcc/x86_64-pc-linux/$GCC_VERSION/32/crtendS.o"

for x in "$@"; do
    if [[ "$x" == *"clang_rt.crtbegin-x86_64.o"* ]]; then
        args+=("$GCC_CRTBEGIN_x86_64")
    elif [[ "$x" == *"clang_rt.crtend-x86_64.o"* ]]; then
        args+=("$GCC_CRTEND_x86_64")
    elif [[ "$x" == *"clang_rt.crtbegin-i386.o"* ]]; then
        args+=("$GCC_CRTBEGIN_i386")
    elif [[ "$x" == *"clang_rt.crtend-i386.o"* ]]; then
        args+=("$GCC_CRTEND_i386")
    else
        args+=("$x")
    fi
done

echo "Invoking linker with correct crt files..."
echo ">>" "$ld" "${args[@]}"

exec "/sucks/gnu/bin/$ld" "${args[@]}"
