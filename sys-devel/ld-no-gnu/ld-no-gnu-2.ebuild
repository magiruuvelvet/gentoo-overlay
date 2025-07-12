EAPI=7

DESCRIPTION="filter GNU libraries during linking for very broken build systems"
LICENSE="MIT"

SLOT="0"
KEYWORDS="*"
IUSE=""

RDEPEND="
    llvm-core/clang
    llvm-core/lld
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
