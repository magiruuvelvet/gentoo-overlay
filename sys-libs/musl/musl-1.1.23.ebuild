# side-by-side musl installation with glibc
# installed under /usr/musl
#
# this is a first attempt to perform an inplace migration
# to musl without reinstalling everything from scratch
# with a new stage tarball based on musl
#
# that way you still have glibc installed and easy
# recovers are possible on breakage or boot failures
#

EAPI=6

inherit eutils flag-o-matic multilib toolchain-funcs
if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="git://git.musl-libc.org/musl"
	inherit git-r3
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="http://www.musl-libc.org/releases/${P}.tar.gz"
	KEYWORDS="-* ~amd64 ~x86"
fi

DESCRIPTION="Light, fast and simple C library focused on standards-conformance and safety"
HOMEPAGE="http://www.musl-libc.org/"
LICENSE="MIT LGPL-2 GPL-2"
SLOT="0"

src_prepare() {
    # force usage of compiler-rt
    eapply "${FILESDIR}/01-musl-remove-gcc.patch"
    eapply_user
}

src_configure() {
    echo ">>> configuring x86_64-pc-linux-musl..."
    cp -r "${S}" "${S}/../x86_64"
    cd ../x86_64
    ./configure \
        --prefix=/usr/musl \
        --target=x86_64-pc-linux-musl \
        --libdir=/usr/musl/lib64 \
        --syslibdir=/lib64 \
        --disable-wrapper \
        CC="clang" \
        CFLAGS="${CFLAGS}"
    cd "${S}"

    echo ">>> configuring i686-pc-linux-musl..."
    cp -r "${S}" "${S}/../i686"
    cd ../i686
    ./configure \
        --prefix=/usr/musl \
        --target=i686-pc-linux-musl \
        --libdir=/usr/musl/lib \
        --syslibdir=/lib \
        --disable-wrapper \
        CC="clang -m32" \
        CFLAGS="${CFLAGS} -m32"
    cd "${S}"
}

src_compile() {
    echo ">>> building x86_64-pc-linux-musl..."
    cd "${S}/../x86_64"
    emake

    echo ">>> building i686-pc-linux-musl..."
    cd "${S}/../i686"
    emake
}

src_install() {
    cd "${S}/../i686"
    emake DESTDIR="${D}" install
    rm -r "${D}/usr/musl/include"

    cd "${S}/../x86_64"
    emake DESTDIR="${D}" install

    # install musl tools
    install -D -m755 "${FILESDIR}/ldd" "${D}/usr/musl/bin/ldd"

    # install migration wrapper
    install -d "${D}/usr/bin"
    ln -s /usr/musl/bin/ldd "${D}/usr/bin/musl-ldd"
    install -D -m755 "${FILESDIR}/musl-clang" "${D}/usr/bin/musl-clang"
    install -D -m755 "${FILESDIR}/musl-clang++" "${D}/usr/bin/musl-clang++"
    install -D -m755 "${FILESDIR}/ld.musl-clang" "${D}/usr/bin/ld.musl-clang"
    install -D -m755 "${FILESDIR}/ld.musl-clang++" "${D}/usr/bin/ld.musl-clang++"
}
