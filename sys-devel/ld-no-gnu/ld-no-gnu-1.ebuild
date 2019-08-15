EAPI=7

DESCRIPTION="filter GNU libraries during linking for very broken build systems"
LICENSE="MIT"

SLOT="0"
KEYWORDS="*"
IUSE=""

RDEPEND="
    sys-devel/clang
    sys-devel/lld
"

src_unpack() {
    mkdir -p "${S}"
}

src_install() {
    insinto /usr/bin

    for i in "${FILESDIR}"/*; do
        install -m755 "$i" "${ED}/usr/bin/"
    done
}
