EAPI=7

inherit qmake-utils

HOMEPAGE="https://github.com/CJCombrink/SpellChecker-Plugin"
DESCRIPTION="SpellChecker Plugin for Qt Creator"
LICENSE="GPL-3.0"
SLOT="0"

# ATTENTION: this ebuild is incompatible with 32-bit !!
# hardcoded lib64 lib dir

# NOTE: building qt creator plugins inside a sandbox is cancer
# the entire plugin pri files are fucked up and are totally
# incompatible with packaging and out of place builds
# (thanks qt creator devs, love you guys)
# at least src_configure doesn't already compile the package

KEYWORDS="amd64"

SRC_URI="https://github.com/CJCombrink/SpellChecker-Plugin/archive/v${PV}.tar.gz -> ${PN}-${PV}.tgz"

S="${WORKDIR}/SpellChecker-Plugin-${PV}"

DEPEND="
    dev-qt/qt-creator
    app-text/hunspell
"

BDEPEND="
    dev-qt/qt-creator-src
"

PATCHES="
    ${FILESDIR}/3427accd188e9c85c08a25b84615098175e4f49b.patch
"

src_prepare() {

    # setup local paths
    cp spellchecker_local_paths.pri.example spellchecker_local_paths.pri
    sed -i 's/LOCAL_QTCREATOR_SOURCES=.*/LOCAL_QTCREATOR_SOURCES=\/usr\/src\/dev-qt\/qt-creator/g' spellchecker_local_paths.pri
    echo "LOCAL_IDE_BUILD_TREE=/usr" >> spellchecker_local_paths.pri

    eapply_user
    default
}

src_configure() {
    # FIXME: DESTDIR is not stable and may change without notice
    eqmake5 \
        QTC_SOURCE="/usr/src/dev-qt/qt-creator" \
        QTC_BUILD="/usr" \
        USE_USER_DESTDIR=true

    # fix Makefile
    # FIXME: how can the LIB path be overwritten in qmake plugin building??
    sed -i 's/\/usr\/lib\/qtcreator/\/usr\/lib64\/qtcreator/g' Makefile
}

src_compile() {
    emake
}

src_install() {
    mkdir -p "${D}/usr/lib64/qtcreator/plugins"
    # FIXME: this path doesn't seem very stable and may change without notice
    cp "${HOME}/.local/share/data/QtProject/qtcreator/plugins/"*"/"* "${D}/usr/lib64/qtcreator/plugins/"
}
