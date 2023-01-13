#!/bin/bash

# simple helper script to quickly update linphone ebuilds

old="$1"
new="$2"

linphone_pkgs=(
    dev-libs/liblinphone
    net-libs/bctoolbox
    dev-cpp/belr
    dev-libs/belle-sip
    net-libs/ortp
    net-libs/bzrtp
    media-libs/mediastreamer2
    dev-libs/belcard
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
