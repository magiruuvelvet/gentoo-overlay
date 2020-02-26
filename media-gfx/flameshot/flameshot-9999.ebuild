EAPI=7

inherit git-r3 qmake-utils toolchain-funcs xdg-utils

DESCRIPTION="Powerful yet simple to use screenshot software"
HOMEPAGE="https://flameshot.js.org"
#EGIT_REPO_URI="https://github.com/lupoDharkael/${PN}.git"
EGIT_REPO_URI="https://github.com/magiruuvelvet/${PN}.git"

LICENSE="FreeArt GPL-3+ Apache-2.0"
SLOT="0"

DEPEND="
    >=dev-qt/qtsvg-5.3.0:5
    >=dev-qt/qtcore-5.3.0:5
    >=dev-qt/qtdbus-5.3.0:5
    >=dev-qt/qtnetwork-5.3.0:5
    >=dev-qt/qtwidgets-5.3.0:5
    >=dev-qt/linguist-tools-5.3.0:5
"
RDEPEND="${DEPEND}"

# NOTE: patches are part of my fork
#PATCHES="
#    ${FILESDIR}/remove-imgur-feature.patch
#    ${FILESDIR}/save-screenshot-on-enter-key-press.patch
#"

src_prepare(){
    sed -i "s#icons#pixmaps#" ${PN}.pro
    sed -i "s#^Icon=.*#Icon=${PN}#" "docs/desktopEntry/package/${PN}.desktop"

    # remove imgur files to really make sure it is disabled (depends on the above patch)
    #rm "${S}/src/tools/imgur/imguruploadertool.cpp"
    #rm "${S}/src/tools/imgur/imguruploader.cpp"
    #rm "${S}/src/tools/imgur/imguruploadertool.h"
    #rm "${S}/src/tools/imgur/imguruploader.h"

    default
}

src_configure(){
    eqmake5 CONFIG+=packaging
}

src_install(){
    INSTALL_ROOT="${D}" default
}

pkg_postinst(){
    xdg_desktop_database_update
}

pkg_postrm(){
    xdg_desktop_database_update
}
