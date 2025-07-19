EAPI=8

inherit kde.org

DESCRIPTION="Plasma 6 applet that shows the application title and icon for active window"
HOMEPAGE="https://github.com/moodyhunter/applet-window-title6"
SLOT=0

S="${WORKDIR}/plasma-applet-window-title-${PV}"

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
    kde-plasma/plasma-workspace:6
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
