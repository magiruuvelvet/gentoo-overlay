EAPI=7

DESCRIPTION="linker script to make static linking with clang and lld against glibc possible"
LICENSE="MIT"

SLOT="0"
KEYWORDS="*"
IUSE=""

DEPEND="
    sys-libs/glibc
"

src_unpack() {
    mkdir -p "${S}"
}

src_install() {
    local target32="${ED}/sucks/gnu/glibc-static/32"
    install -d "$target32"
    cp "${FILESDIR}/libc_32.a" "$target32/libc.a"
    ln -s /usr/lib/libc.so "$target32/libc.so"

    local target64="${ED}/sucks/gnu/glibc-static/64"
    install -d "$target64"
    cp "${FILESDIR}/libc_64.a" "$target64/libc.a"
    ln -s /usr/lib64/libc.so "$target64/libc.so"
}
