EAPI=8

inherit kde.org

DESCRIPTION="Prime Render Offload Status"
HOMEPAGE="https://store.kde.org/p/1411472"
SRC_URI="https://storage.magiruuvelvet.gdn/ebuild/${PN}-${PV}.tgz"
SLOT=0
KEYWORDS="*"

PLASMOID_NAME="org.kde.plasma.prostatus"

S="${WORKDIR}/$PLASMOID_NAME"

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
