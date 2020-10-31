# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=(python3_{6,7,8})
inherit bash-completion-r1 distutils-r1 readme.gentoo-r1

REAL_PN=yt-dlc
DESCRIPTION="Download videos from YouTube.com (and more sites...)"
HOMEPAGE="https://github.com/blackjack4494/yt-dlc/"
SRC_URI="https://github.com/blackjack4494/yt-dlc/archive/${PV}.tar.gz"
LICENSE="public-domain"

KEYWORDS="amd64 arm ~arm64 hppa ppc ppc64 x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"
RDEPEND="
	dev-python/pycryptodome[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	test? (
		dev-python/nose[${PYTHON_USEDEP}]
		dev-python/flake8[${PYTHON_USEDEP}]
	)
"
S="${WORKDIR}/${REAL_PN}-${PV}"

src_compile() {
	distutils-r1_src_compile
}

python_test() {
	emake offlinetest
}

python_install_all() {
	distutils-r1_python_install_all

	rm -r "${ED}"/usr/etc || die
	rm -r "${ED}"/usr/share/doc/youtube_dlc || die

	ln -s youtube-dlc "${ED}/usr/bin/youtube-dl"
}
