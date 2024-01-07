# based on https://aur.archlinux.org/pi-hole-server.git

EAPI=8

PV_ADMINLTE=5.1.1

SRC_URI="
    https://github.com/pi-hole/pi-hole/archive/v${PV}.tar.gz -> pihole-cli-${PV}.tar.gz
    https://github.com/pi-hole/AdminLTE/archive/v${PV_ADMINLTE}.tar.gz -> pihole-web-${PV}.tar.gz
"

SLOT="0"
KEYWORDS="*"
IUSE="sudo doas"

RDEPEND="
    >=net-dns/pihole-${PV}
    <net-dns/pihole-5.3
    app-shells/bash
    sudo? ( app-admin/sudo )
    doas? ( app-admin/doas )
"

REQUIRED_USE="^^ ( sudo doas )"

src_unpack() {
    unpack ${A}
    mkdir "${S}"
}

src_prepare() {
    # change to correct directory for patches to apply
    cd "${S}/.."

    # fix wrong or generic paths
    patch -s -p0 < "${FILESDIR}/5.x/arch-server-admin-5.1.1.patch"
    patch -s -p0 < "${FILESDIR}/5.x/arch-server-core-5.1.2.patch"

    if use doas; then
        patch -p1 < "${FILESDIR}/5.x/use-doas-instead-of-sudo.patch"
    fi

    # note: don't call "default" here as non-standard paths are used

    # apply user patches
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
    install -Dm755 advanced/Scripts/wildcard_regex_converter.sh "${D}"/opt/pihole/wildcard_regex_converter.sh
    install -Dm755 advanced/Scripts/query.sh "${D}"/opt/pihole/query.sh
    install -Dm755 advanced/Scripts/pihole-reenable.sh "${D}"/opt/pihole/pihole-reenable.sh
    install -Dm755 advanced/Scripts/piholeARPTable.sh "${D}"/opt/pihole/piholeARPTable.sh

    install -Dm644 advanced/Scripts/COL_TABLE "${D}"/opt/pihole/COL_TABLE

    install -Dm644 advanced/Templates/gravity.db.sql "${D}"/opt/pihole/gravity.db.sql
    install -Dm644 advanced/Templates/gravity_copy.sql "${D}"/opt/pihole/gravity_copy.sql

    install -Dm755 "${FILESDIR}/5.x/piholeDebug.sh" "${D}"/opt/pihole/piholeDebug.sh
    install -Dm755 "${FILESDIR}/5.x/mimic_setupVars.conf.sh" "${D}"/opt/pihole/mimic_setupVars.conf.sh
    install -Dm755 "${FILESDIR}/5.x/mimic_basic-install.sh" "${D}"/opt/pihole/basic-install.sh

    cp -dpr --no-preserve=ownership advanced/Scripts/database_migration "${D}"/opt/pihole/

    if use sudo; then
        # install required sudoers rule
        install -dm750 "${D}"/etc/sudoers.d
        install -Dm440 advanced/Templates/pihole.sudo "${D}"/etc/sudoers.d/pihole
    fi

    # install tmpfiles
    install -Dm644 "${FILESDIR}/5.x/pi-hole.tmpfile" "${D}"/usr/lib/tmpfiles.d/pi-hole.conf

    # install systemd units
    install -Dm644 "${FILESDIR}/5.x/pi-hole-gravity.timer" "${D}/usr/lib/systemd/system/pi-hole-gravity.timer"
    install -Dm644 "${FILESDIR}/5.x/pi-hole-gravity.service" "${D}/usr/lib/systemd/system/pi-hole-gravity.service"
    install -Dm644 "${FILESDIR}/5.x/pi-hole-logtruncate.timer" "${D}/usr/lib/systemd/system/pi-hole-logtruncate.timer"
    install -Dm644 "${FILESDIR}/5.x/pi-hole-logtruncate.service" "${D}/usr/lib/systemd/system/pi-hole-logtruncate.service"
    install -dm755 "${D}/usr/lib/systemd/system/multi-user.target.wants"
    ln -s ../pi-hole-gravity.timer "${D}/usr/lib/systemd/system/multi-user.target.wants/pi-hole-gravity.timer"
    ln -s ../pi-hole-logtruncate.timer "${D}/usr/lib/systemd/system/multi-user.target.wants/pi-hole-logtruncate.timer"

    # install configuration templates
    install -dm755 "${D}"/etc/pihole
    install -dm755 "${D}"/usr/share/pihole/configs
    install -Dm644 adlists.list "${D}"/etc/pihole/adlists.list
cat <<EOF > dns-servers.conf
DNS.WATCH;84.200.69.80;84.200.70.40;2001:1608:10:25:0:0:1c04:b12f;2001:1608:10:25:0:0:9249:d69b
Cloudflare;1.1.1.1;1.0.0.1;2606:4700:4700::1111;2606:4700:4700::1001
EOF
    install -Dm644 dns-servers.conf "${D}"/etc/pihole/dns-servers.conf
    install -Dm644 advanced/Templates/logrotate "${D}"/etc/pihole/logrotate

    # install web interface
    cd "${S}/../AdminLTE-${PV_ADMINLTE}"
    install -dm755 "${D}"/srv/http/pihole/admin
    install -Dm644 "${S}/../pi-hole-${PV}"/advanced/index.php "${D}"/srv/http/pihole/pihole/index.php
    install -Dm644 "${S}/../pi-hole-${PV}"/advanced/blockingpage.css "${D}"/srv/http/pihole/pihole/blockingpage.css
    cp -dpr --no-preserve=ownership * "${D}"/srv/http/pihole/admin/
}
