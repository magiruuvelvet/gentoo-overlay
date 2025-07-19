EAPI=8

PLASMA_MINIMAL="5.27"
QT_MINIMAL="5.15"
FRAMEWORKS_MINIMAL="5.110"

inherit ecm kde.org git-r3

DESCRIPTION="Material-ish window decoration theme for KWin"
HOMEPAGE="https://github.com/guiodic/material-decoration"

EGIT_REPO_URI="https://github.com/guiodic/material-decoration"

LICENSE="GPL-2"
SLOT="0"

PATCHES="
	${FILESDIR}/01-delete-bundled-libdbusmenuqt.patch
	${FILESDIR}/02-delete-dbus-appmenu.patch
    ${FILESDIR}/03-fix-cmake-set-calls.patch
"

DEPEND="
    >=dev-qt/qtbase-${QT_MINIMAL}[dbus]
    >=kde-frameworks/kconfig-${FRAMEWORKS_MINIMAL}:6
    >=kde-frameworks/kconfigwidgets-${FRAMEWORKS_MINIMAL}:6
    >=kde-frameworks/kwindowsystem-${FRAMEWORKS_MINIMAL}:6
    >=kde-frameworks/kcoreaddons-${FRAMEWORKS_MINIMAL}:6
    >=kde-frameworks/kguiaddons-${FRAMEWORKS_MINIMAL}:6
    >=kde-frameworks/kiconthemes-${FRAMEWORKS_MINIMAL}:6
    >=kde-frameworks/ki18n-${FRAMEWORKS_MINIMAL}:6
    >=kde-plasma/kdecoration-${PLASMA_MINIMAL}:6
    >=kde-plasma/kwayland-${PLASMA_MINIMAL}:6
    >=kde-plasma/kwin-x11-${PLASMA_MINIMAL}:6
    x11-libs/libxcb
"
RDEPEND="${DEPEND}"
