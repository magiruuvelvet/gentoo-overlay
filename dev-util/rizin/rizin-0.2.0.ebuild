EAPI=7

inherit meson

DESCRIPTION="UNIX-like reverse engineering framework and command-line toolset"
HOMEPAGE="https://github.com/rizinorg/rizin"
LICENSE="LGPL-3.0"
SLOT=0
KEYWORDS="amd64 x86"

SRC_URI="https://github.com/rizinorg/${PN}/releases/download/v${PV}/${PN}-src-v${PV}.tar.xz"

S="${WORKDIR}/${PN}-v${PV}"

PATCHES="
    ${FILESDIR}/meson-fallback-fix.patch
"

BDEPEND="
    virtual/pkgconfig
"

DEPEND="
    sys-apps/file
    app-arch/lz4:0=
    dev-libs/capstone:0=
    dev-libs/libuv:0=
    dev-libs/libzip:0=
    dev-libs/openssl:0=
    dev-libs/tree-sitter
    dev-libs/xxhash
    sys-libs/zlib:0=
"

src_configure() {
    export CFLAGS="${CFLAGS} -D_GNU_SOURCE"
    export CXXFLAGS="${CXXFLAGS} -D_GNU_SOURCE"

    local emesonargs=(
        -Dcli=enabled
        -Duse_sys_capstone=enabled
        -Duse_sys_magic=enabled
        -Duse_sys_zip=enabled
        -Duse_sys_zlib=enabled
        -Duse_sys_lz4=enabled
        -Duse_sys_xxhash=enabled
        -Duse_sys_openssl=enabled
        -Duse_sys_tree_sitter=enabled
        -Drizin_plugins="/usr/share/rizin/plugins"
    )

    meson_src_configure
}
