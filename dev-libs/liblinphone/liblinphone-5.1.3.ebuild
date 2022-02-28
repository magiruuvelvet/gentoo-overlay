# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )

inherit cmake

DESCRIPTION="SIP library supporting voice/video calls and text messaging"
HOMEPAGE="https://gitlab.linphone.org/BC/public/liblinphone"
SRC_URI="https://github.com/BelledonneCommunications/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="libnotify"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	dev-db/sqlite:3
	dev-db/soci[sqlite]
	dev-libs/libxml2:2
	sys-libs/zlib:0
	virtual/libiconv
	virtual/libintl
	virtual/libudev
	net-libs/bctoolbox
	dev-cpp/belr
	dev-libs/belle-sip
	media-libs/mediastreamer2
	net-libs/ortp
	dev-libs/belcard
"
DEPEND="${RDEPEND}"
BDEPEND="${PYTHON_DEPS}
	>=dev-python/pystache-0.6.1
	dev-python/six
"

src_configure() {
	local mycmakeargs=(
		-DENABLE_ASSISTANT=OFF
		-DENABLE_DEBUG_LOGS=OFF
		-DENABLE_DOC=OFF
		-DENABLE_LDAP=OFF
		-DENABLE_LIME=OFF
		-DENABLE_LIME_X3DH=OFF
		-DENABLE_NOTIFY="$(usex libnotify)"
		-DENABLE_STATIC=OFF
		-DENABLE_TOOLS=OFF
		-DENABLE_UNIT_TESTS=OFF
		-DENABLE_VIDEO=OFF
		-DENABLE_VCARD=ON
		-DENABLE_ADVANCED_IM=OFF
		-DENABLE_DB_STORAGE=ON
		-DENABLE_FLEXIAPI=OFF
	)

	cmake_src_configure
}
