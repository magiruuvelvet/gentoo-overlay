EAPI=7

inherit ecm kde.org git-r3

DESCRIPTION="KRunner integration for Kiten Japanese dictionary"

EGIT_REPO_URI="https://github.com/magiruuvelvet/${PN}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm arm64 ~ppc64 x86"
IUSE=""

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
