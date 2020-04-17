EAPI=7

PLASMA_MINIMAL="5.12"
QT_MINIMAL="5.9"
FRAMEWORKS_MINIMAL="5.38"
inherit kde.org

MY_PN="${PN/plasma-}"

DESCRIPTION="Plasma 5 applet in order to show window buttons in your panels"
HOMEPAGE="https://github.com/psifidotos/applet-window-buttons"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	SRC_URI=""
	KEYWORDS=""
	EGIT_REPO_URI="https://github.com/psifidotos/${MY_PN}.git"
else
	MY_P="${MY_PN}-${PV}"
	SRC_URI="https://github.com/psifidotos/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
	S="${WORKDIR}/${MY_P}"
fi

IUSE=""

DEPEND="
	kde-frameworks/plasma
	kde-frameworks/frameworkintegration
	dev-qt/qtdbus
	x11-libs/libxcb
"
RDEPEND="${DEPEND}"
