EAPI=7

DESCRIPTION="A complete reference for the features in the C++ Standard Library, for Qt help"
HOMEPAGE="https://en.cppreference.com"
LICENSE="CCPL:cc-by-sa"
KEYWORDS="alpha amd64 arm arm64 hppa ia64 m68k mips ppc ppc64 s390 sparc x86"
SRC_URI="https://upload.cppreference.com/mwiki/images/5/5a/qch_book_$PV.tar.xz"
SLOT="0"

RESTRICT="mirror"

S="${WORKDIR}"

src_install() {
    mkdir -p "${ED}/usr/share/doc/qtcreator"
    cp "${S}/cppreference-doc-en-cpp.qch" "${ED}/usr/share/doc/qtcreator/"
    docompress -x /usr/share/doc/qtcreator/cppreference-doc-en-cpp.qch
}
