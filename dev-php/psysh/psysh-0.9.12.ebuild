EAPI=7

DESCRIPTION="REPL for PHP"
HOMEPAGE="https://psysh.org/ ${GH_HOMEPAGE}"
LICENSE="MIT"

SLOT="0"
SRC_URI="https://github.com/bobthecow/${PN}/releases/download/v${PV}/${PN}-v${PV}.tar.gz"

KEYWORDS="~amd64 ~arm ~arm64"

RDEPEND="
    dev-lang/php
"

S="${WORKDIR}"

src_configure() { : ; }
src_compile() { : ; }

src_install() {
    dobin "${PN}"
}
