# Copyright 2017-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
PYTHON_COMPAT=(python{3_6,3_7,3_8})
DISTUTILS_SINGLE_IMPL="1"

inherit distutils-r1 git-r3

SRC_URI=""
EGIT_REPO_URI="https://chromium.googlesource.com/external/gyp"
EGIT_COMMIT="fcd686f1880fa52a1ee78d3e98af1b88cb334528"

DESCRIPTION="GYP (Generate Your Projects) meta-build system"
HOMEPAGE="https://gyp.gsrc.io/ https://chromium.googlesource.com/external/gyp"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~ppc64 x86"
IUSE=""

PATCHES="
    ${FILESDIR}/gyp-fix-cmake.patch
    ${FILESDIR}/gyp-python38.patch
"
