EAPI=7

inherit meson multilib-minimal git-r3

DESCRIPTION="a vulkan post processing layer"
HOMEPAGE="https://github.com/DadSchoorse/vkBasalt"
LICENSE="zlib"
SLOT=0
KEYWORDS="~amd64"

EGIT_REPO_URI="${HOMEPAGE}"

BDEPEND="
    dev-util/vulkan-headers
    dev-util/spirv-headers
"
RDEPEND="
    media-libs/vulkan-loader[${MULTILIB_USEDEP}]
    x11-libs/libX11[${MULTILIB_USEDEP}]
    dev-util/glslang[${MULTILIB_USEDEP}]
"
DEPEND="${RDEPEND}"

multilib_src_configure() {
    local emesonargs=(
        --buildtype=release
        --prefix /usr
    )

    meson_src_configure
}

multilib_src_compile() {
    meson_src_compile
}

multilib_src_install() {
    meson_src_install
}
