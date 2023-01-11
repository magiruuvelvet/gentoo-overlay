EAPI=7

inherit dlang

DESCRIPTION="rdmd is a companion to the dmd compiler"
HOMEPAGE="https://code.dlang.org/"
LICENSE="Boost"

SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="debug"

SRC_URI="https://raw.githubusercontent.com/dlang/tools/v${PV}/rdmd.d -> ${P}.d"

S="${WORKDIR}"

src_unpack() {
    cp "${DISTDIR}/${P}.d" "${WORKDIR}/rdmd.d"
}

d_src_compile() {
    local sources=( "rdmd.d" )
    dlang_compile_bin rdmd $sources
}

d_src_install() {
    dobin rdmd
}
