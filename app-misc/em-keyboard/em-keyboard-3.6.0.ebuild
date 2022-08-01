# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1

DESCRIPTION="the cli emoji keyboard"
HOMEPAGE="https://github.com/hugovk/em-keyboard"
SRC_URI="https://files.pythonhosted.org/packages/10/9e/842d329dcdf244533e463d8d063637c38a67e9b920b6b55c81d6f77b2d5e/em_keyboard-3.6.0.tar.gz"
S="${WORKDIR}/em_keyboard-${PV}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="**"
RESTRICT="test"
