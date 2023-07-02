EAPI=7

inherit git-r3 cmake

DESCRIPTION="A PipeWire Graph Qt GUI Interface"
HOMEPAGE="https://gitlab.freedesktop.org/rncbc/qpwgraph"

EGIT_REPO_URI="https://gitlab.freedesktop.org/rncbc/qpwgraph"

LICENSE="GPL-2.0"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="
    dev-qt/qtcore
    dev-qt/qtgui
    dev-qt/qtwidgets
    dev-qt/qtnetwork
    dev-qt/qtxml
    media-video/pipewire
"

pkg_postinst() {
    xdg_desktop_database_update
    xdg_mimeinfo_database_update
}

pkg_postrm() {
    xdg_desktop_database_update
    xdg_mimeinfo_database_update
}
