EAPI=7

inherit meson multilib-minimal git-r3

DESCRIPTION="A Vulkan and OpenGL overlay for monitoring FPS, temperatures, CPU/GPU load and more"
HOMEPAGE="https://github.com/flightlessmango/MangoHud"
LICENSE="MIT"
SLOT=0
KEYWORDS="amd64 x86"

EGIT_REPO_URI="${HOMEPAGE}"

IMGUI_VERSION=1.89.9
VULKAN_HEADERS_VERSION=1.2.158
IMPLOT_VERSION=0.16

SRC_URI="
    https://github.com/ocornut/imgui/archive/v${IMGUI_VERSION}.tar.gz -> ${PN}-imgui-${IMGUI_VERSION}.tgz
    https://wrapdb.mesonbuild.com/v2/imgui_${IMGUI_VERSION}-1/get_patch -> ${PN}-imgui-${IMGUI_VERSION}-meson.zip

    https://github.com/KhronosGroup/Vulkan-Headers/archive/v${VULKAN_HEADERS_VERSION}.tar.gz -> ${PN}-vulkan-headers-${VULKAN_HEADERS_VERSION}.tgz
    https://wrapdb.mesonbuild.com/v2/vulkan-headers_${VULKAN_HEADERS_VERSION}-2/get_patch -> ${PN}-vulkan-headers-${VULKAN_HEADERS_VERSION}-meson.zip

    https://github.com/epezent/implot/archive/refs/tags/v${IMPLOT_VERSION}.zip -> ${PN}-implot-${IMPLOT_VERSION}.zip
    https://wrapdb.mesonbuild.com/v2/implot_0.16-1/get_patch -> ${PN}-implot-${IMPLOT_VERSION}-meson.zip
"

BDEPEND="
    virtual/pkgconfig
    app-arch/libarchive
"

RDEPEND="
    media-libs/vulkan-loader[${MULTILIB_USEDEP}]
    virtual/opengl[${MULTILIB_USEDEP}]
    sys-apps/dbus[${MULTILIB_USEDEP}]
    x11-libs/libX11[${MULTILIB_USEDEP}]
"

DEPEND="
    dev-libs/spdlog
    ${RDEPEND}
"

PATCHES="
    ${FILESDIR}/disable-config-lookup-in-exe-path.patch
    ${FILESDIR}/remove-log-uploading-feature.patch
    ${FILESDIR}/include-missing-headers.patch
"

src_prepare() {
    einfo "Unpacking meson subproject: imgui-${IMGUI_VERSION}"
    bsdtar -C "${S}/subprojects/" -xf "${DISTDIR}/${PN}-imgui-${IMGUI_VERSION}.tgz"
    bsdtar -C "${S}/subprojects/" -xf "${DISTDIR}/${PN}-imgui-${IMGUI_VERSION}-meson.zip"

    einfo "Unpacking meson subproject: vulkan-headers-${VULKAN_HEADERS_VERSION}"
    bsdtar -C "${S}/subprojects/" -xf "${DISTDIR}/${PN}-vulkan-headers-${VULKAN_HEADERS_VERSION}.tgz"
    bsdtar -C "${S}/subprojects/" -xf "${DISTDIR}/${PN}-vulkan-headers-${VULKAN_HEADERS_VERSION}-meson.zip"

    einfo "Unpacking meson subproject: implot-${IMPLOT_VERSION}"
    bsdtar -C "${S}/subprojects/" -xf "${DISTDIR}/${PN}-implot-${IMPLOT_VERSION}.zip"
    bsdtar -C "${S}/subprojects/" -xf "${DISTDIR}/${PN}-implot-${IMPLOT_VERSION}-meson.zip"

    default
}

multilib_src_configure() {
    local emesonargs=(
        --buildtype=release
        --prefix /usr
        -Dappend_libdir_mangohud=false
        -Duse_system_spdlog=enabled
        -Dwith_xnvctrl=disabled
        -Dwith_x11=enabled
    )

    meson_src_configure
}

multilib_src_compile() {
    meson_src_compile
}

multilib_src_install() {
    meson_src_install
}
