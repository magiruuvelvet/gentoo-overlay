EAPI=7

inherit meson

DESCRIPTION="UNIX-like reverse engineering framework and command-line toolset"
HOMEPAGE="https://github.com/rizinorg/rizin"
LICENSE="LGPL-3.0"
SLOT=0
KEYWORDS="amd64 x86"

SRC_URI="https://github.com/rizinorg/${PN}/releases/download/v${PV}/${PN}-src-v${PV}.tar.xz"

BDEPEND="
    virtual/pkgconfig
"

DEPEND="
    dev-libs/openssl
    dev-libs/libuv
    sys-libs/zlib
    dev-libs/capstone
    dev-libs/libzip
    app-arch/lz4
    dev-libs/xxhash
"

src_configure() {
    export CFLAGS="${CFLAGS} -D_GNU_SOURCE"
    export CXXFLAGS="${CXXFLAGS} -D_GNU_SOURCE"

    local emesonargs=(
        -Duse_sys_magic=true
        -Duse_sys_openssl=true
        -Duse_sys_libuv=true
        -Duse_sys_zlib=true
        -Duse_sys_capstone=true
        -Duse_sys_libzip=true
        -Duse_sys_lz4=true
        -Duse_sys_xxhash=true
    )

    meson_src_configure
}
