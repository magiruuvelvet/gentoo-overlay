EAPI=8

inherit cmake xdg-utils

MY_PN="hyperion.ng"

QMDNSENGINE_COMMIT="0ca80117e853671d909b3cec9e2bdcac85a13b9f"

DESCRIPTION="Hyperion is an opensource Bias or Ambient Lighting implementation"
HOMEPAGE="https://hyperion-project.org/"
SRC_URI="
    https://github.com/hyperion-project/${MY_PN}/archive/refs/tags/${PV}.tar.gz
    https://github.com/nitroshare/qmdnsengine/archive/${QMDNSENGINE_COMMIT}.zip -> qmdnsengine-${QMDNSENGINE_COMMIT}.zip
"

S="${WORKDIR}/${MY_PN}-${PV}"

KEYWORDS="amd64"
LICENSE="MIT"
SLOT="0"

DEPEND="
    dev-qt/qtcore:5
    dev-qt/qtgui:5
    dev-qt/qtwidgets:5
    dev-qt/qtnetwork:5
    dev-qt/qtdbus:5
    dev-qt/qtsql:5
    dev-lang/python
    net-libs/mbedtls
    media-libs/alsa-lib
    x11-libs/libX11
    x11-libs/libxcb
    x11-libs/libXrandr
    x11-libs/libXext
    x11-libs/libXrender
"
RDEPEND="${DEPEND}"

# TODO: maybe useflag those
# dev-libs/flatbuffers
# dev-libs/protobuf
# dev-libs/libcec
# virtual/libusb

src_unpack() {
    default

    pushd "${WORKDIR}" >/dev/null 2>&1
    rmdir "${MY_PN}-${PV}/dependencies/external/qmdnsengine"
    mv "qmdnsengine-${QMDNSENGINE_COMMIT}" "${MY_PN}-${PV}/dependencies/external/qmdnsengine"
    popd >/dev/null 2>&1
}

src_configure() {
    local mycmakeargs=(
        -DBUILD_SHARED_LIBS=OFF
        -DENABLE_DEPLOY_DEPENDENCIES=OFF

        -DUSE_SYSTEM_PROTO_LIBS=ON
        -DUSE_SYSTEM_MBEDTLS_LIBS=ON
        -DUSE_SYSTEM_FLATBUFFERS_LIBS=ON
        -DUSE_SYSTEM_QMDNS_LIBS=OFF

        -DENABLE_MDNS=OFF
        -DENABLE_DEV_SERIAL=OFF
        -DENABLE_DEV_SPI=OFF
        -DENABLE_DEV_TINKERFORGE=OFF
        -DENABLE_DEV_USB_HID=OFF
        -DENABLE_DEV_WS281XPWM=OFF
        -DENABLE_REMOTE_CTL=OFF
        -DENABLE_V4L2=OFF
        -DENABLE_PROTOBUF_SERVER=OFF
        -DENABLE_FLATBUF_SERVER=OFF
        -DENABLE_FLATBUF_CONNECT=OFF
        -DENABLE_FORWARDER=OFF
        -DENABLE_CEC=OFF
        -DENABLE_FB=OFF

        -DENABLE_QT=ON
        -DENABLE_AUDIO=ON
        -DENABLE_DEV_NETWORK=ON
        -DENABLE_X11=ON
        -DENABLE_XCB=ON
        -DENABLE_EFFECTENGINE=ON
    )

    cmake_src_configure
}

src_install() {
    cmake_src_install

    # install a better systemd unit which supports the --user flag
    local systemd_unit="${ED}/usr/share/hyperion/service/hyperion.systemd"
    rm "${systemd_unit}"
    cp "${FILESDIR}/hyperion.service" "${systemd_unit}"
}

pkg_postinst() {
    xdg_desktop_database_update
}

pkg_postrm() {
    xdg_desktop_database_update
}
