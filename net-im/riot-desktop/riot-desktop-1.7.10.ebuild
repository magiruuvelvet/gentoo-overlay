# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A glossy Matrix collaboration client for desktop"
HOMEPAGE="https://riot.im"

inherit unpacker xdg-utils

SRC_URI="https://github.com/vector-im/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
    https://github.com/vector-im/element-web/archive/v${PV}.tar.gz -> riot-web-${PV}.tar.gz"
KEYWORDS="~amd64"

LICENSE="Apache-2.0"
SLOT="0"
IUSE=""
REQUIRED_USE=""

RESTRICT="network-sandbox"

RDEPEND="
    dev-db/sqlcipher
    dev-libs/expat
    dev-libs/nspr
    dev-libs/nss
    net-libs/nodejs
    x11-libs/cairo
    x11-libs/gdk-pixbuf:2
    x11-libs/gtk+:3
    x11-libs/libxcb
    x11-libs/libX11
    x11-libs/libXcomposite
    x11-libs/libXcursor
    x11-libs/libXdamage
    x11-libs/libXext
    x11-libs/libXfixes
    x11-libs/libXi
    x11-libs/libXrandr
    x11-libs/libXrender
    x11-libs/libXtst
    x11-libs/libXScrnSaver
    x11-libs/pango"
DEPEND="${RDEPEND}"
BDEPEND="
    sys-apps/yarn
    dev-vcs/git"

QA_PREBUILT="
    /opt/Element/chrome-sandbox
    /opt/Element/element-desktop
    /opt/Element/libEGL.so
    /opt/Element/libGLESv2.so
    /opt/Element/libffmpeg.so
    /opt/Element/libvk_swiftshader.so
    /opt/Element/swiftshader/libEGL.so
    /opt/Element/swiftshader/libGLESv2.so"

PN_NEW="element-desktop"
S="${WORKDIR}/element-desktop-${PV}"
ELEMENT_WEB_S="${WORKDIR}/element-web-${PV}"

src_prepare() {
    default

    # apply all patches
    pushd "${ELEMENT_WEB_S}" >/dev/null || die
    echo "applying web patches..."
    git apply "${FILESDIR}/${PV}/web-"* || true
    git apply "${FILESDIR}/web-custom-css.patch" || die

    popd || die
    echo "applying desktop patches..."
    git apply "${FILESDIR}/${PV}/desktop-"* || true

    # install web dependencies
    pushd "${ELEMENT_WEB_S}" >/dev/null || die
    yarn install || die
    cp config.sample.json config.json || die

    # install desktop dependencies
    popd || die
    yarn install || die
}

src_compile() {
    pushd "${ELEMENT_WEB_S}" >/dev/null || die
    yarn build || die

    popd || die
    ln -sf "${ELEMENT_WEB_S}"/webapp ./ || die
    yarn build:native || die
    yarn build || die
}

src_install() {
    unpack dist/${PN_NEW}_${PV}_amd64.deb
    tar -xvf data.tar.xz || die

    ./node_modules/asar/bin/asar.js p webapp opt/Element/resources/webapp.asar || die

    insinto /
    doins -r usr
    doins -r opt
    local f
    for f in ${QA_PREBUILT}; do
        fperms +x "${f}"
    done
    dosym ../../opt/Element/${PN_NEW} /usr/bin/${PN}
    dosym ../../opt/Element/${PN_NEW} /usr/bin/${PN_NEW}
}

pkg_postinst() {
    xdg_desktop_database_update
    xdg_icon_cache_update
}

pkg_postrm() {
    xdg_desktop_database_update
    xdg_icon_cache_update
}
