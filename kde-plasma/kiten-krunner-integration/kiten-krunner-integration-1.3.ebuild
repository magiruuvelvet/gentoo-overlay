EAPI=8

inherit ecm kde.org

DESCRIPTION="KRunner integration for Kiten Japanese dictionary"

SRC_URI="https://github.com/magiruuvelvet/${PN}/releases/download/${PV}/${PN}-${PV}.zip -> ${PN}-${PV}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm arm64 ~ppc64 x86"
IUSE=""

S="${WORKDIR}"

DEPEND="
    dev-qt/qtcore
    dev-qt/qtgui
    dev-qt/qtwidgets
    kde-frameworks/kconfig
    kde-frameworks/kcoreaddons
    kde-frameworks/ki18n
    kde-frameworks/krunner
    kde-apps/kiten
"
RDEPEND="${DEPEND}"
