EAPI=7

inherit git-r3 cmake-utils

DESCRIPTION="A glossy Matrix collaboration client for desktop"
HOMEPAGE="https://github.com/magiruuvelvet/qelement"

EGIT_REPO_URI="https://github.com/magiruuvelvet/qelement.git"

LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE="+libnotify"

# custom build types are not supported by this project
CMAKE_BUILD_TYPE=Release

DEPEND="
    dev-qt/qtcore
    dev-qt/qtgui
    dev-qt/qtwidgets
    dev-qt/qtnetwork
    dev-qt/qtconcurrent
    dev-qt/qtwebengine
    libnotify? ( x11-libs/libnotify )
"
RDEPEND="${DEPEND}"

src_configure() {
    local mycmakeargs=(
        -DENABLE_LIBNOTIFY=$(usex libnotify)
    )

    cmake-utils_src_configure
}

src_install() {
    cmake-utils_src_install
    rm -r "${D}/usr/share/doc"
}
