# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

QTMIN=6.8.1
inherit git-r3 ecm flag-o-matic plasma.kde.org toolchain-funcs

DESCRIPTION="Task management and system monitoring application"

LICENSE="LGPL-2+"
SLOT="6/9"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"
IUSE=""

EGIT_REPO_URI="https://github.com/zvova7890/ksysguard6"
EGIT_BRANCH=kf6

DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[dbus,gui,network,widgets]
	kde-plasma/libksysguard:6
"
