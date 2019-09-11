EAPI=7

DESCRIPTION="compat wrapper for ld.bfd and ld.gold"
LICENSE="MIT"

SLOT="0"
KEYWORDS="*"
IUSE=""

src_unpack() {
    mkdir -p "${S}"
}

src_install() {
    TARGET=/opt/gnu/compat
    insinto $TARGET

    install -m755 "${FILESDIR}/ld.sh" "${ED}$TARGET/ld.bfd"
    install -m755 "${FILESDIR}/ld.sh" "${ED}$TARGET/ld.gold"

    install -m755 "${FILESDIR}/ldS.sh" "${ED}$TARGET/ld.bfdS"
    install -m755 "${FILESDIR}/ldS.sh" "${ED}$TARGET/ld.goldS"

    install -m755 "${FILESDIR}/ld-orig.sh" "${ED}$TARGET/ld.bfdO"
    install -m755 "${FILESDIR}/ld-orig.sh" "${ED}$TARGET/ld.goldO"
}
