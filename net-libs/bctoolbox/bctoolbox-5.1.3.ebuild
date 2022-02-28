# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Utilities library used by Belledonne Communications softwares"
HOMEPAGE="https://gitlab.linphone.org/BC/public/bctoolbox"
SRC_URI="https://github.com/BelledonneCommunications/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="0"

RDEPEND="net-libs/mbedtls"
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		-DENABLE_POLARSSL=OFF
		-DENABLE_MBEDTLS=ON
		-DENABLE_STATIC=OFF
		-DENABLE_TESTS_COMPONENT=OFF
		-DENABLE_TESTS=OFF
	)

	cmake_src_configure
}
