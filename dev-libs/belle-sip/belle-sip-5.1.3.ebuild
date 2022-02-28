# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="SIP (RFC3261) implementation"
HOMEPAGE="https://github.com/BelledonneCommunications/belle-sip"
SRC_URI="https://github.com/BelledonneCommunications/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="0"

RDEPEND="
	sys-libs/zlib:=
	net-libs/bctoolbox
	dev-cpp/belr
"
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		-DENABLE_MDNS=OFF
		-DENABLE_STATIC=OFF
		-DENABLE_TESTS=OFF
	)

	cmake_src_configure
}
