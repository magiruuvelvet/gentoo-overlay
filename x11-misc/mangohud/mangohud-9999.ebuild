EAPI=7

inherit meson multilib-minimal git-r3

DESCRIPTION="A Vulkan and OpenGL overlay for monitoring FPS, temperatures, CPU/GPU load and more"
HOMEPAGE="https://github.com/flightlessmango/MangoHud"
LICENSE="MIT"
SLOT=0
KEYWORDS="amd64 x86"

EGIT_REPO_URI="${HOMEPAGE}"

# enabling this feature on multi GPU systems is not recommended
# as it breaks mangohud for non-NVIDIA GPUs
IUSE="-xnvctrl"

BDEPEND="
    dev-util/vulkan-headers
    virtual/pkgconfig
    xnvctrl? ( x11-libs/libxnvctrl )
"
RDEPEND="
    media-libs/vulkan-loader[${MULTILIB_USEDEP}]
    virtual/opengl[${MULTILIB_USEDEP}]
    sys-apps/dbus[${MULTILIB_USEDEP}]
    x11-libs/libX11[${MULTILIB_USEDEP}]
"
DEPEND="${RDEPEND}"

multilib_src_configure() {
    local emesonargs=(
        --buildtype=release
        --prefix /usr
        -Dappend_libdir_mangohud=false
        -Duse_system_vulkan=enabled
        -Dwith_xnvctrl=$(usex xnvctrl enabled disabled)
    )

    meson_src_configure
}

multilib_src_compile() {
    meson_src_compile
}

multilib_src_install() {
    meson_src_install
}
