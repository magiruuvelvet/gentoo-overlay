EAPI=7

inherit meson git-r3

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
    media-libs/vulkan-loader
    x11-libs/libX11
    dev-util/glslang
"
DEPEND="${RDEPEND}"

src_configure() {
    local emesonargs=(
        --buildtype=release
        --prefix /usr
    )

    meson_src_configure
}
