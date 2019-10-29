EAPI=7

HOMEPAGE="https://doc.qt.io/qtcreator/"
DESCRIPTION="Qt Creator source code"
LICENSE="GPL-3"
SLOT="0"

KEYWORDS="*"

MY_PV=${PV/_/-}
MY_P=qt-creator-opensource-src-${MY_PV}
[[ ${MY_PV} == ${PV} ]] && MY_REL=official || MY_REL=development
SRC_URI="https://download.qt.io/${MY_REL}_releases/${PN/-}/${PV%.*}/${MY_PV}/${MY_P}.tar.xz"
S=${WORKDIR}/${MY_P}

DEPEND="=dev-qt/qt-creator-${PV}"

src_configure() {
    : # skip configure
}

src_compile() {
    : # skip compile
}

src_install() {
    mkdir -p "${D}/usr/src/dev-qt/qt-creator/"
    cp -a "${S}/." "${D}/usr/src/dev-qt/qt-creator/"
}
