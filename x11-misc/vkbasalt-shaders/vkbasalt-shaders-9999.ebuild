EAPI=7

inherit git-r3

DESCRIPTION="shaders for vkbasalt"
HOMEPAGE="https://github.com/crosire/reshade-shaders"
LICENSE=""
SLOT=0
KEYWORDS="**"

EGIT_BRANCH="master"
EGIT_REPO_URI="${HOMEPAGE}"

DEPEND="x11-misc/vkbasalt"

src_install() {
    insinto /usr/share/vkbasalt/reshade-shaders
    cp -r Shaders Textures "${ED}/usr/share/vkbasalt/reshade-shaders/"
    cp REFERENCE.md "${ED}/usr/share/vkbasalt/reshade-shaders/"
}
