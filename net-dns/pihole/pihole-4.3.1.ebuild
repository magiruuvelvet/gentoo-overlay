# based on https://aur.archlinux.org/pi-hole-ftl.git

EAPI=7

inherit eutils

SRC_URI="https://github.com/pi-hole/FTL/archive/v${PV}.tar.gz -> pihole-${PV}.tar.gz"

SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="
    dev-libs/nettle
    dev-libs/gmp
"

PATCHES=(
    "${FILESDIR}/4.3/makefile.patch"
    "${FILESDIR}/4.3/nettle-3.5.patch"
)

# move files in place to make portage happy
src_unpack() {
    unpack ${A}
    mkdir "${S}"
    cd "${S}/.."
    mv FTL*/* ${PN}-${PV}/
}

# patch static linking to dynamic linking
src_prepare() {
    default
    eapply_user
}

# embedded sqlite complains about stringop-truncation a lot
src_compile() {
    CFLAGS="$CFLAGS -fPIC -Wno-error=stringop-truncation"
    CXXFLAGS="$CXXFLAGS -fPIC -Wno-error=stringop-truncation"
    emake
}

# manually install files as there is no install target
src_install() {
    install -Dm755 pihole-FTL "${D}"/usr/bin/pihole-FTL

    install -Dm644 "${FILESDIR}/4.3/pi-hole-ftl.tmpfile" "${D}"/usr/lib/tmpfiles.d/pi-hole-ftl.conf

    install -dm755 "${D}"/etc/pihole
    install -Dm644 "${FILESDIR}/4.3/pi-hole-ftl.conf" "${D}"/etc/pihole/pihole-FTL.conf
    install -Dm644 "${FILESDIR}/4.3/pi-hole-ftl.db" "${D}"/etc/pihole/pihole-FTL.db

    install -Dm644 "${FILESDIR}/4.3/pi-hole-ftl.service" "${D}"/usr/lib/systemd/system/pihole-FTL.service
    install -dm755 "${D}/usr/lib/systemd/system/multi-user.target.wants"
    ln -s ../pihole-FTL.service "${D}/usr/lib/systemd/system/multi-user.target.wants/pihole-FTL.service"
}
