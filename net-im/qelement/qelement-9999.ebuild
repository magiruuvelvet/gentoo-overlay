EAPI=7

inherit git-r3 cmake

DESCRIPTION="A glossy Matrix collaboration client for desktop"
HOMEPAGE="https://github.com/magiruuvelvet/qelement"

EGIT_REPO_URI="https://github.com/magiruuvelvet/qelement.git"

LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE="+libnotify +translations"

# custom build types are not supported by this project
CMAKE_BUILD_TYPE=Release

DEPEND="
    dev-qt/qtbase:6[gui,widgets,network,concurrent]
    dev-qt/qtwebengine:6
    translations? ( dev-qt/qttools:6[linguist] )
    libnotify? ( x11-libs/libnotify )
"
RDEPEND="${DEPEND}"

src_configure() {
    local mycmakeargs=(
        -DENABLE_LIBNOTIFY=$(usex libnotify)
        -DBUILD_TRANSLATIONS=$(usex translations)
    )

    cmake_src_configure || die
}

src_install() {
    cmake_src_install || die
    rm -r "${D}/usr/share/doc"
}
