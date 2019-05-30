# based on https://aur.archlinux.org/pi-hole-server.git

EAPI=7

inherit eutils

SRC_URI="
    https://github.com/pi-hole/pi-hole/archive/v${PV}.tar.gz -> pihole-cli-${PV}.tar.gz
    https://github.com/pi-hole/AdminLTE/archive/v${PV}.tar.gz -> pihole-web-${PV}.tar.gz
"

SLOT="0"
KEYWORDS="*"
IUSE=""

RDEPEND="
    >=net-dns/pihole-${PV}
    app-shells/bash
"

# fix wrong or generic paths
PATCHES=(
    "${FILESDIR}/fix-paths-and-remove-update-uninstall-functions.patch"
    "${FILESDIR}/version.patch"
)

src_unpack() {
    unpack ${A}
    mkdir "${S}"
}

src_prepare() {
    cd "${S}/../pi-hole-${PV}"
    patch -s -p0 < "${FILESDIR}"/fix-paths-and-remove-update-uninstall-functions.patch
    patch -s -p0 < "${FILESDIR}"/version.patch
    eapply_user
}

src_install() {
    # install command line utilities
    cd "${S}/../pi-hole-${PV}"
    install -Dm755 pihole "${D}"/usr/bin/pihole

    install -dm755 "${D}"/opt/pihole
    install -Dm755 gravity.sh "${D}"/opt/pihole/gravity.sh
    install -Dm755 advanced/Scripts/version.sh "${D}"/opt/pihole/version.sh
    install -Dm755 advanced/Scripts/piholeLogFlush.sh "${D}"/opt/pihole/piholeLogFlush.sh
    install -Dm755 advanced/Scripts/chronometer.sh "${D}"/opt/pihole/chronometer.sh
    install -Dm755 advanced/Scripts/list.sh "${D}"/opt/pihole/list.sh
    install -Dm755 advanced/Scripts/webpage.sh "${D}"/opt/pihole/webpage.sh
    install -Dm755 advanced/Scripts/COL_TABLE "${D}"/opt/pihole/COL_TABLE
    install -Dm755 advanced/Scripts/wildcard_regex_converter.sh "${D}"/opt/pihole/wildcard_regex_converter.sh
    install -Dm755 advanced/Scripts/query.sh "${D}"/opt/pihole/query.sh

    install -Dm755 "${FILESDIR}/mimic_setupVars.conf.sh" "${D}"/opt/pihole/mimic_setupVars.conf.sh

    # install required sudoers rule
    install -dm750 "${D}"/etc/sudoers.d
    install -Dm440 advanced/Templates/pihole.sudo "${D}"/etc/sudoers.d/pihole

    # install tmpfiles
    install -Dm644 "${FILESDIR}/pi-hole.tmpfile" "${D}"/usr/lib/tmpfiles.d/pi-hole.conf

    # install systemd units
    install -Dm644 "${FILESDIR}/pi-hole-gravity.timer" "${D}/usr/lib/systemd/system/pi-hole-gravity.timer"
    install -Dm644 "${FILESDIR}/pi-hole-gravity.service" ${D}/usr/lib/systemd/system/pi-hole-gravity.service
    install -Dm644 "${FILESDIR}/pi-hole-logtruncate.timer" "${D}/usr/lib/systemd/system/pi-hole-logtruncate.timer"
    install -Dm644 "${FILESDIR}/pi-hole-logtruncate.service" ${D}/usr/lib/systemd/system/pi-hole-logtruncate.service
    install -dm755 "${D}/usr/lib/systemd/system/multi-user.target.wants"
    ln -s ../pi-hole-gravity.timer "${D}/usr/lib/systemd/system/multi-user.target.wants/pi-hole-gravity.timer"
    ln -s ../pi-hole-logtruncate.timer "${D}/usr/lib/systemd/system/multi-user.target.wants/pi-hole-logtruncate.timer"

    # install configuration templates
    install -dm755 "${D}"/etc/pihole
    install -dm755 "${D}"/usr/share/pihole/configs
    install -Dm644 adlists.list "${D}"/etc/pihole/adlists.list
    install -Dm644 advanced/Templates/logrotate "${D}"/etc/pihole/logrotate
    install -Dm644 /dev/null "${D}"/etc/pihole/whitelist.txt
    install -Dm644 /dev/null "${D}"/etc/pihole/blacklist.txt
    install -Dm644 /dev/null "${D}"/etc/pihole/regex.list

    # install web interface
    cd "${S}/../AdminLTE-${PV}"
    install -dm755 "${D}"/srv/http/pihole/admin
    install -Dm644 "${S}/../pi-hole-${PV}"/advanced/index.php "${D}"/srv/http/pihole/pihole/index.php
    install -Dm644 "${S}/../pi-hole-${PV}"/advanced/blockingpage.css "${D}"/srv/http/pihole/pihole/blockingpage.css
    cp -dpr --no-preserve=ownership * "${D}"/srv/http/pihole/admin/
}
