EAPI=8

inherit cmake git-r3

MY_PN="HyperHDR"

DESCRIPTION="Highly optimized open source ambient lighting implementation"
HOMEPAGE="http://www.hyperhdr.eu/"
EGIT_REPO_URI="https://github.com/awawa-dev/HyperHDR"

KEYWORDS="amd64"
LICENSE="MIT"
SLOT="0"

# DO NOT USE Qt6 YET!
DEPEND="
    dev-qt/qtcore:5
    dev-qt/qtgui:5
    dev-qt/qtnetwork:5
    dev-qt/qtserialport:5
    dev-qt/qtsql:5
    dev-qt/qtwidgets:5
    dev-libs/protobuf
    app-arch/xz-utils
    app-arch/lzma
    x11-libs/libX11
    media-video/pipewire
    media-libs/libglvnd
    media-libs/libjpeg-turbo
"
BDEPEND="
    sys-kernel/linux-headers
    dev-lang/python
"
RDEPEND="${DEPEND}"

# NOTE TO SELF: the build system of HyperHDR is garbage, network discovery is enforced
PATCHES="
    ${FILESDIR}/remove-bonjour-enforcement.patch
    ${FILESDIR}/fix-compiler-error-without-bonjour.patch
    ${FILESDIR}/remove-enforced-deploy.patch
    ${FILESDIR}/cmake-exclude-external-from-installing.patch
"

src_configure() {
    local mycmakeargs=(
        -DBUILD_SHARED_LIBS=OFF
        -DDO_NOT_USE_QT_VERSION_6_LIBS=ON
        -DUSE_STATIC_QT_PLUGINS=OFF

        -DDEFAULT_PROTOBUF=ON
        -DDEFAULT_X11=ON
        -DDEFAULT_PIPEWIRE=ON
        -DDEFAULT_PIPEWIRE_EGL=ON
        -DDEFAULT_FRAMEBUFFER=ON
        -DDEFAULT_XZ=ON

        -DDEFAULT_BONJOUR=OFF
        -DDEFAULT_MQTT=OFF
        -DDEFAULT_BOBLIGHT=OFF
        -DDEFAULT_V4L2=OFF
        -DDEFAULT_PRECOMPILED_HEADERS=OFF
        -DDEFAULT_POWER_MANAGEMENT=OFF
        -DDEFAULT_SOUNDCAPLINUX=OFF
        -DDEFAULT_CEC=OFF
        -DDEFAULT_WS281XPWM=OFF

        -DENABLE_V4L2=OFF
        -DENABLE_SOUNDCAPLINUX=OFF
        -DENABLE_BONJOUR=OFF
        -DENABLE_MQTT=OFF
        -DENABLE_POWER_MANAGEMENT=OFF
        -DUSE_PRECOMPILED_HEADERS=OFF

        -DDEFAULT_USE_SYSTEM_FLATBUFFERS_LIBS=OFF
        -DUSE_SYSTEM_FLATBUFFERS_LIBS=OFF
        -DDEFAULT_USE_SYSTEM_MBEDTLS_LIBS=OFF
        -DUSE_SYSTEM_MBEDTLS_LIBS=OFF
        -DDEFAULT_USE_SYSTEM_MQTT_LIBS=OFF
    )

    cmake_src_configure
}

src_install() {
    cmake_src_install

    # install "smart" wrapper libraries
    local smartlibdir="${ED}/usr/share/hyperhdr/lib"
    mkdir -p "${smartlibdir}"
    cp "${WORKDIR}/${P}_build/lib/libsmart"* "${smartlibdir}/"

#     # install a better systemd unit which supports the --user flag
#     local systemd_unit="${ED}/usr/share/hyperion/service/hyperion.systemd"
#     rm "${systemd_unit}"
#     cp "${FILESDIR}/hyperion.service" "${systemd_unit}"
}
