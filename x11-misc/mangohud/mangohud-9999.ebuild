EAPI=7

inherit meson multilib-minimal git-r3

DESCRIPTION="A Vulkan and OpenGL overlay for monitoring FPS, temperatures, CPU/GPU load and more"
HOMEPAGE="https://github.com/flightlessmango/MangoHud"
LICENSE="MIT"
SLOT=0
KEYWORDS="amd64 x86"

EGIT_REPO_URI="${HOMEPAGE}"

IMGUI_VERSION=1.81
SPDLOG_VERSION=1.8.5

SRC_URI="
    https://github.com/ocornut/imgui/archive/v${IMGUI_VERSION}.tar.gz -> ${PN}-imgui-${IMGUI_VERSION}.tgz
    https://wrapdb.mesonbuild.com/v2/imgui_${IMGUI_VERSION}-1/get_patch -> ${PN}-imgui-${IMGUI_VERSION}-meson.zip

    https://github.com/gabime/spdlog/archive/v${SPDLOG_VERSION}.tar.gz -> ${PN}-spdlog-${SPDLOG_VERSION}.tgz
    https://wrapdb.mesonbuild.com/v2/spdlog_${SPDLOG_VERSION}-1/get_patch -> ${PN}-spdlog-${SPDLOG_VERSION}-meson.zip
"

BDEPEND="
    dev-util/vulkan-headers
    virtual/pkgconfig
    app-arch/libarchive
"

RDEPEND="
    media-libs/vulkan-loader[${MULTILIB_USEDEP}]
    virtual/opengl[${MULTILIB_USEDEP}]
    sys-apps/dbus[${MULTILIB_USEDEP}]
    x11-libs/libX11[${MULTILIB_USEDEP}]
"

DEPEND="${RDEPEND}"

PATCHES="
    ${FILESDIR}/disable-config-lookup-in-exe-path.patch
    ${FILESDIR}/remove-log-uploading-feature.patch
"

src_prepare() {
    einfo "Unpacking meson subproject: imgui-${IMGUI_VERSION}"
    bsdtar -C "${S}/subprojects/" -xf "${DISTDIR}/${PN}-imgui-${IMGUI_VERSION}.tgz"
    bsdtar -C "${S}/subprojects/" -xf "${DISTDIR}/${PN}-imgui-${IMGUI_VERSION}-meson.zip"

    einfo "Unpacking meson subproject: spdlog-${SPDLOG_VERSION}"
    bsdtar -C "${S}/subprojects/" -xf "${DISTDIR}/${PN}-spdlog-${SPDLOG_VERSION}.tgz"
    bsdtar -C "${S}/subprojects/" -xf "${DISTDIR}/${PN}-spdlog-${SPDLOG_VERSION}-meson.zip"

    default
}

multilib_src_configure() {
    local emesonargs=(
        --buildtype=release
        --prefix /usr
        -Dappend_libdir_mangohud=false
        -Duse_system_vulkan=enabled
        -Duse_system_spdlog=disabled
        -Dwith_xnvctrl=disabled
    )

    meson_src_configure
}

multilib_src_compile() {
    meson_src_compile
}

multilib_src_install() {
    meson_src_install
}
