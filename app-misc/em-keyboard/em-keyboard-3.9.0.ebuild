# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

_DIST_URL_PATH="69/f3/d042a9b52b5fc615c62ae173494d646c49477bf0edea9d524263a7b28f77"

DESCRIPTION="the cli emoji keyboard"
HOMEPAGE="https://github.com/hugovk/em-keyboard"
SRC_URI="https://files.pythonhosted.org/packages/${_DIST_URL_PATH}/em_keyboard-${PV}.tar.gz"
S="${WORKDIR}/em_keyboard-${PV}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="**"
RESTRICT="test"

# TODO: figure out how to correctly use python_foreach_impl (QA notice)
python_install() {
    distutils-r1_python_install

    # install missing files (why is distutils-r1 not catching these?)
    installation() {
        cp "${S}/em/__init__.py" "${D}$(python_get_sitedir)/em/"
        cp "${S}/em/emoji-en-US.json" "${D}$(python_get_sitedir)/em/"
    }

    python_foreach_impl installation
}
