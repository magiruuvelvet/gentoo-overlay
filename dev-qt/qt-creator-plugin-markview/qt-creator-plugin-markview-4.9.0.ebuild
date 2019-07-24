EAPI=7

inherit qmake-utils

HOMEPAGE="https://github.com/OneMoreGres/qtc-markview"
DESCRIPTION="Markdown support for Qt Creator"
LICENSE="MIT"
SLOT="0"

# ATTENTION: this ebuild is incompatible with 32-bit !!
# hardcoded lib64 lib dir

# NOTE: building qt creator plugins inside a sandbox is cancer
# the entire plugin pri files are fucked up and are totally
# incompatible with packaging and out of place builds
# (thanks qt creator devs, love you guys)
# at least src_configure doesn't already compile the package

KEYWORDS="amd64"

SRC_URI="https://github.com/OneMoreGres/qtc-markview/archive/${PV}.tar.gz -> ${PN}-${PV}.tgz"

S="${WORKDIR}/qtc-markview-${PV}"

QT_CREATOR_VERSION="4.9.2"

DEPEND="
    =dev-qt/qt-creator-$QT_CREATOR_VERSION
"

BDEPEND="
    =dev-qt/qt-creator-src-$QT_CREATOR_VERSION
"

src_prepare() {
    sed -i 's/\$\$QTCREATOR_SOURCES/\/usr\/src\/dev-qt\/qt-creator/g' qtc-markview.pro
    eapply_user
}

src_configure() {
    # FIXME: DESTDIR is not stable and may change without notice
    eqmake5 \
        QTCREATOR_SOURCES="/usr/src/dev-qt/qt-creator" \
        IDE_BUILD_TREE="/usr" \
        QTC_SOURCE="/usr/src/dev-qt/qt-creator" \
        QTC_BUILD="/usr" \
        USE_USER_DESTDIR=true

    # fix Makefile
    # FIXME: how can the LIB path be overwritten in qmake plugin building??
    sed -i 's/\/usr\/lib\/qtcreator/\/usr\/lib64\/qtcreator/g' Makefile

    # bad .pro causing issues??
    sed -i 's/\-lCore/\-L\/usr\/lib64\/qtcreator\ \-L\/usr\/lib64\/qtcreator\/plugins\ \-lCore/g' Makefile
}

src_compile() {
    emake
}

src_install() {
    mkdir -p "${D}/usr/lib64/qtcreator/plugins"
    # FIXME: this path doesn't seem very stable and may change without notice
    cp "${HOME}/.local/share/data/QtProject/qtcreator/plugins/$QT_CREATOR_VERSION/"* "${D}/usr/lib64/qtcreator/plugins/"
}
