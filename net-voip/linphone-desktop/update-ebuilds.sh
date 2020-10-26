#!/bin/bash

# simple helper script to quickly update linphone ebuilds

old="$1"
new="$2"

linphone_pkgs=(
    "dev-libs/liblinphone"
    "dev-libs/belcard"
    "dev-libs/belle-sip"
    "dev-libs/lime"
    "media-libs/mediastreamer2"
    "net-libs/bctoolbox"
    "net-libs/bzrtp"
    "net-libs/ortp"
    "dev-cpp/belr"
)

cd ../..

for pkg in ${linphone_pkgs[@]}; do
    IFS='/' read -a ebuild <<< "$pkg"
    old_ebuild="${ebuild[1]}-$old.ebuild"
    new_ebuild="${ebuild[1]}-$new.ebuild"
    pushd $pkg >/dev/null
    echo -e "\e[1m$old_ebuild -> $new_ebuild\e[0m"
    cp "$old_ebuild" "$new_ebuild"
    popd >/dev/null
done
