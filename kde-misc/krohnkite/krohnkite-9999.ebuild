EAPI=7

inherit git-r3

EGIT_REPO_URI="https://github.com/anametologin/krohnkite.git"

HOMEPAGE="https://github.com/anametologin/krohnkite.git"
DESCRIPTION="A dynamic tiling extension for KWin"
LICENSE="MIT"

SLOT="0"
KEYWORDS=""
IUSE=""

PATCHES="
    ${FILESDIR}/do-not-run-npm.patch
"

# IMPORTANT!
# this ebuild is a hack which only works on my local machine

# build dependencies
# typescript 5.x+
# npm install typescript

RDEPEND="
    kde-plasma/kwin:6
"

src_compile() {
    export HOME="${S}/pkg"
    export PATH="/opt/nodejs/pkg/bin:$PATH"
    make -e install
}

src_install() {
    install -d "${D}/usr/share/kwin/scripts/${PN}"
    cp -ra "${S}/pkg/.local/share/kwin/scripts/${PN}/." "${D}/usr/share/kwin/scripts/${PN}/"
    install -Dm644 "${S}/pkg/.local/share/kwin/scripts/${PN}/metadata.desktop" "${D}/usr/share/kservices6/${PN}.desktop"
}
