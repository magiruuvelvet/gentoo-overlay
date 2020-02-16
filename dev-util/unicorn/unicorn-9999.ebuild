# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

MY_PV=${PV/_/-}

PYTHON_COMPAT=( python3_{6,7,8} )
inherit multilib distutils-r1 git-r3

DESCRIPTION="A lightweight multi-platform, multi-architecture CPU emulator framework"
HOMEPAGE="http://www.unicorn-engine.org"
SRC_URI=""
EGIT_REPO_URI="https://github.com/yuzu-emu/unicorn.git"
EGIT_BRANCH="master"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~m68k ~arm ~arm64 ~mips ~sparc"
IUSE="python static-libs"

IUSE_UNICORN_TARGETS="x86 m68k arm aarch64 mips sparc"
use_unicorn_targets=$(printf ' unicorn_targets_%s' ${IUSE_UNICORN_TARGETS})
IUSE+=" ${use_unicorn_targets}"

DEPEND="dev-libs/glib:2
	${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	virtual/pkgconfig"

REQUIRED_USE="|| ( ${use_unicorn_targets} )"

S="${WORKDIR}/${PN}-${MY_PV}"

src_configure(){
	local target
	unicorn_softmmu_targets=""

	for target in ${IUSE_UNICORN_TARGETS} ; do
		if use "unicorn_targets_${target}"; then
			unicorn_targets+="${target} "
		fi
	done

	#the following variable is getting recreated using UNICORN_ARCHS below
	UNICORN_TARGETS=""
	default
}

src_compile() {
	export CC INSTALL_BIN PREFIX PKGCFGDIR LIBDIRARCH LIBARCHS CFLAGS LDFLAGS
	UNICORN_QEMU_FLAGS="--python=/usr/bin/python" \
		UNICORN_ARCHS="${unicorn_targets}" \
		UNICORN_STATIC="$(use static-libs && echo yes || echo no)" \
		emake
}

src_install() {
	emake DESTDIR="${D}" LIBDIR="/usr/$(get_libdir)" UNICORN_STATIC="$(use static-libs && echo yes || echo no)" install
}
