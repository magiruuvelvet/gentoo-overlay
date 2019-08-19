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
    insinto /usr/bin

    install -m755 "${FILESDIR}/ld.sh" "${ED}/usr/bin/ld.bfd"
    install -m755 "${FILESDIR}/ld.sh" "${ED}/usr/bin/ld.gold"

    install -m755 "${FILESDIR}/ldS.sh" "${ED}/usr/bin/ld.bfdS"
    install -m755 "${FILESDIR}/ldS.sh" "${ED}/usr/bin/ld.goldS"

    install -m755 "${FILESDIR}/ld-orig.sh" "${ED}/usr/bin/ld.bfdO"
    install -m755 "${FILESDIR}/ld-orig.sh" "${ED}/usr/bin/ld.goldO"
}
