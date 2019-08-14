EAPI=7

DESCRIPTION="compat aliases for clang"
LICENSE="MIT"

SLOT="0"
KEYWORDS="*"
IUSE=""

RDEPEND="
    sys-devel/clang
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
