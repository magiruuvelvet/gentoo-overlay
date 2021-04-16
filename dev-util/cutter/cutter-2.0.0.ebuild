# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

TRANS_COMMIT="974298653ba71b958e1b6c83f6011f5fefff6236"

inherit cmake toolchain-funcs xdg-utils

DESCRIPTION="A Qt and C++ GUI for rizin reverse engineering framework"
HOMEPAGE="https://cutter.re https://github.com/rizinorg/cutter/"
SRC_URI="https://github.com/rizinorg/cutter/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/rizinorg/cutter-translations/archive/${TRANS_COMMIT}.tar.gz -> cutter-translations-${TRANS_COMMIT}.tar.gz"

LICENSE="CC-BY-SA-3.0 GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

COMMON_DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
	dev-util/rizin:0=
	media-gfx/graphviz
	kde-frameworks/syntax-highlighting"
DEPEND="${COMMON_DEPEND}
	dev-qt/linguist-tools:5"
RDEPEND="${COMMON_DEPEND}"

src_prepare() {
	rmdir "${S}/src/translations" || die
	mv "${WORKDIR}/cutter-translations-${TRANS_COMMIT}" \
	   "${S}/src/translations" || die

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_CXX_COMPILER="$(tc-getCXX)"
		-DCMAKE_C_COMPILER="$(tc-getCC)"
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr"
		-DCUTTER_ENABLE_DEPENDENCY_DOWNLOADS=OFF
		-DCUTTER_ENABLE_GRAPHVIZ=ON
		-DCUTTER_ENABLE_KSYNTAXHIGHLIGHTING=ON
		-DCUTTER_ENABLE_PYTHON=OFF
		-DCUTTER_USE_BUNDLED_RIZIN=OFF
		-DCUTTER_ENABLE_CRASH_REPORTS=OFF
		-DCUTTER_EXTRA_PLUGIN_DIRS="/usr/share/RizinOrg/Cutter/plugins:/usr/share/rizin/plugins"
	)

	cmake_src_configure
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
