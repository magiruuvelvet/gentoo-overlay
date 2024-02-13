EAPI=8

inherit kde.org

DESCRIPTION="Prime Render Offload Status"
HOMEPAGE="https://store.kde.org/p/1411472"
SRC_URI="https://github.com/magiruuvelvet/org.kde.plasma.prostatus/archive/refs/heads/amdgpu.zip -> ${PN}-git.zip"
SLOT=0
KEYWORDS="*"

PLASMOID_NAME="org.kde.plasma.prostatus"

S="${WORKDIR}/$PLASMOID_NAME-amdgpu"

IUSE=""

DEPEND="
    kde-plasma/plasma-workspace
"
RDEPEND="${DEPEND}"

src_configure() {
    :
}

src_prepare() {
    default
}

src_compile() {
    :
}

src_install() {
    local target="$ED/usr/share/plasma/plasmoids/$PLASMOID_NAME"
    mkdir -p "$target"
    cp -r "$S/"* "$target"
}
