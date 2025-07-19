# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PLASMA_MINIMAL="6.3"
QT_MINIMAL="6.8"
FRAMEWORKS_MINIMAL="6.13"
inherit ecm kde.org

DESCRIPTION="Plasma 6 applet in order to show the window appmenu"
HOMEPAGE="https://github.com/proatgram/applet-window-appmenu6"

PATCHES="
    ${FILESDIR}/use-kdecoration3.patch
"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/proatgram/applet-window-appmenu6"
else
	MY_P="applet-window-appmenu6-${PV}"
	SRC_URI="https://github.com/proatgram/applet-window-appmenu6/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
	S="${WORKDIR}/${MY_P}"
fi

LICENSE="GPL-2"
SLOT="6"

DEPEND="
    >=kde-plasma/libplasma-${PLASMA_MINIMAL}:6
    >=kde-plasma/plasma-workspace-${PLASMA_MINIMAL}:6
    >=kde-frameworks/frameworkintegration-${FRAMEWORKS_MINIMAL}:6
    >=dev-qt/qtbase-${QT_MINIMAL}[dbus]
    x11-libs/libxcb
"
RDEPEND="${DEPEND}"
