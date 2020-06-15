EAPI=7

DESCRIPTION="CMake help for Qt Creator"
HOMEPAGE="https://cmake.org/documentation/"
KEYWORDS="alpha amd64 arm arm64 hppa ia64 m68k mips ppc ppc64 s390 sparc x86"
SRC_URI="https://cmake.org/cmake/help/v$PV/CMake.qch"
SLOT="0"

RESTRICT="mirror"

S="${WORKDIR}"

src_unpack() {
    cp "${DISTDIR}/"* "${WORKDIR}/"
}

src_install() {
    mkdir -p "${ED}/usr/share/doc/qtcreator"
    cp "${S}/CMake.qch" "${ED}/usr/share/doc/qtcreator/"
    docompress -x /usr/share/doc/qtcreator/CMake.qch
}
