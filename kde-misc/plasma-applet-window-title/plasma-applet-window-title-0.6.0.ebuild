EAPI=7

inherit kde.org

DESCRIPTION="Plasma 5 applet that shows the application title and icon for active window"
HOMEPAGE="https://github.com/psifidotos/applet-window-title"

S="${WORKDIR}/applet-window-title-${PV}"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	SRC_URI=""
	KEYWORDS=""
	EGIT_REPO_URI="${HOMEPAGE}"
else
	SRC_URI="${HOMEPAGE}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi

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
    mkdir -p "$ED/usr/share/plasma/plasmoids/org.kde.windowtitle"
    cp -r "$S/"* "$ED/usr/share/plasma/plasmoids/org.kde.windowtitle"
}
