# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# TODO:
#  - add python use flag and don't force it like Gentoo maintainers
#    (cutter works perfectly fine without python too)

EAPI=7

inherit cmake xdg-utils

cutter_version="3b8f98ca428948af81b70713550c5f3bb7c92c3b"
cutter_translations_version="8e1d24b4040474c681d8db39cb75c0ed66bb5bda"

DESCRIPTION="A Qt and C++ GUI for rizin reverse engineering framework"
HOMEPAGE="https://cutter.re https://github.com/radareorg/cutter/"
#SRC_URI="https://github.com/radareorg/cutter/archive/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI="
    https://github.com/rizinorg/cutter/archive/${cutter_version}.zip -> ${P}.zip
    https://github.com/rizinorg/cutter-translations/archive/${cutter_translations_version}.zip -> ${P}-translations.zip
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND="
    virtual/pkgconfig
"

DEPEND="
    dev-qt/qtcore:5
    dev-qt/qtgui:5
    dev-qt/qtnetwork:5
    dev-qt/qtsvg:5
    dev-qt/qtwidgets:5
    dev-util/rizin
    media-gfx/graphviz
"

RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${cutter_version}"

src_unpack() {
    unpack "${P}.zip"
    unpack "${P}-translations.zip"

    # prepare translations
    rmdir "${PN}-${cutter_version}/src/translations"
    mv "${PN}-translations-${cutter_translations_version}" \
        "${PN}-${cutter_version}/src/translations"
}

src_configure() {
    local mycmakeargs=(
        -DCUTTER_ENABLE_DEPENDENCY_DOWNLOADS=OFF
        -DCUTTER_ENABLE_PYTHON=OFF
        -DCUTTER_USE_BUNDLED_RIZIN=OFF
        -DCUTTER_ENABLE_CRASH_REPORTS=OFF
        
    )

    cmake_src_configure
}

pkg_postinst() {
    xdg_icon_cache_update
}

pkg_postrm() {
    xdg_icon_cache_update
}
