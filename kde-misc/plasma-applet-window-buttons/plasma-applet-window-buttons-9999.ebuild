EAPI=8

PLASMA_MINIMAL="6.3"
QT_MINIMAL="6.8"
FRAMEWORKS_MINIMAL="6.16"
SLOT=0
inherit ecm kde.org

DESCRIPTION="Plasma 6 applet in order to show window buttons in your panels"
HOMEPAGE="https://github.com/moodyhunter/applet-window-buttons6"

#PATCHES="
#	${FILESDIR}/use-kdecoration3.patch
#"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	SRC_URI=""
	KEYWORDS=""
	EGIT_REPO_URI="https://github.com/moodyhunter/applet-window-buttons6"
else
	MY_P="applet-window-buttons6-${PV}"
	SRC_URI="https://github.com/moodyhunter/applet-window-buttons6/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
	S="${WORKDIR}/applet-window-buttons6"
fi

IUSE=""

DEPEND="
	kde-plasma/libplasma:6
	kde-frameworks/frameworkintegration:6
	dev-qt/qtbase:6[dbus]
	x11-libs/libxcb
"
RDEPEND="${DEPEND}"
