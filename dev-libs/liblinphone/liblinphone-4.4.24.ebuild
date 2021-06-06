# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..9} )

inherit cmake python-r1

DESCRIPTION="SIP library supporting voice/video calls and text messaging"
HOMEPAGE="https://gitlab.linphone.org/BC/public/liblinphone"
SRC_URI="https://github.com/BelledonneCommunications/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
ROOT_CA_DL_URL="https://gitlab.linphone.org/BC/public/liblinphone/raw/master/share/rootca.pem"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="debug doc ldap libnotify -video static-libs test tools"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RESTRICT="!test? ( test )"

RDEPEND="dev-cpp/belr
	~dev-cpp/xsd-4.0.0
	dev-db/sqlite:3
	dev-db/soci
	dev-libs/belcard
	dev-libs/belle-sip
	dev-libs/libxml2:2
	dev-libs/lime
	dev-libs/xerces-c
	net-libs/bctoolbox[test?]
	net-libs/ortp
	media-libs/mediastreamer2[zrtp,srtp,jpeg]
	sys-libs/zlib:0
	virtual/libiconv
	virtual/libintl
	virtual/libudev
	tools? ( ${PYTHON_DEPS}
		dev-python/pystache[${PYTHON_USEDEP}]
		dev-python/six[${PYTHON_USEDEP}] )"
DEPEND="${RDEPEND}"
BDEPEND="${PYTHON_DEPS}
	app-doc/doxygen[dot]
	dev-python/pystache[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-vcs/git
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )"

pkg_pretend() {
    if has network-sandbox ${FEATURES} && [[ "${MERGE_TYPE}" != binary ]]; then
        ewarn
        ewarn "${CATEGORY}/${PN} requires 'network-sandbox' to be disabled in FEATURES to download the latest root CA from the source repository"
        ewarn
    fi
}

src_prepare() {
    if ! has network-sandbox ${FEATURES}; then
        wget "${ROOT_CA_DL_URL}" -O "${S}/share/rootca.pem"
    else
        ewarn
        ewarn "Not downloading latest root CA from source repository because 'network-sandbox' is enabled"
        ewarn
    fi

    default
    cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DENABLE_ASSISTANT=YES
		-DENABLE_DEBUG_LOGS="$(usex debug)"
		-DENABLE_DOC="$(usex doc)"
		-DENABLE_LDAP="$(usex ldap)"
		-DENABLE_LIME=NO
		-DENABLE_NOTIFY="$(usex libnotify)"
		-DENABLE_STATIC="$(usex static-libs)"
		-DENABLE_TOOLS="$(usex tools)"
		-DENABLE_UNIT_TESTS="$(usex test)"
		-DENABLE_VIDEO="$(usex video)"
	)

	cmake_src_configure
}
