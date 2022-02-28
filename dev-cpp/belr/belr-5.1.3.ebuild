# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Language recognition library by Belledonne Communications"
HOMEPAGE="https://gitlab.linphone.org/BC/public/belr"
SRC_URI="https://github.com/BelledonneCommunications/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="0"

RDEPEND="net-libs/bctoolbox"
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		-DENABLE_STATIC=OFF
		-DENABLE_TESTS=OFF
		-DENABLE_TOOLS=OFF
	)

	cmake_src_configure
}
