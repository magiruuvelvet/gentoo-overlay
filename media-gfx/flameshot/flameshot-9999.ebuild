EAPI=7

inherit git-r3 cmake xdg-utils

DESCRIPTION="Powerful yet simple to use screenshot software"
HOMEPAGE="https://flameshot.js.org"
#EGIT_REPO_URI="https://github.com/flameshot-org/${PN}.git"
EGIT_REPO_URI="https://github.com/magiruuvelvet/${PN}.git"

LICENSE="FreeArt GPL-3+ Apache-2.0"
SLOT="0"

BDEPEND="
    >=dev-qt/linguist-tools-5.15.0:5
"
DEPEND="
    >=dev-qt/qtcore-5.15.0:5
    >=dev-qt/qtgui-5.15.0:5
    >=dev-qt/qtwidgets-5.15.0:5
    >=dev-qt/qtdbus-5.15.0:5
    >=dev-qt/qtsvg-5.15.0:5
    >=dev-qt/qtnetwork-5.15.0:5
"
RDEPEND="${DEPEND}"

pkg_postinst() {
    xdg_desktop_database_update
}

pkg_postrm() {
    xdg_desktop_database_update
}
