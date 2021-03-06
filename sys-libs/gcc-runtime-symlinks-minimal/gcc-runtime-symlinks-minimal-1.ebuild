EAPI=7

DESCRIPTION="symlink to libgcc_s for pthread_cancel to work"
LICENSE="MIT"

SLOT="0"
KEYWORDS="*"
IUSE=""

src_unpack() {
    mkdir -p "${S}"
}

src_install() {
    GCC_INSTALL_PREFIX=/sucks/gnu
    GCC_32="$GCC_INSTALL_PREFIX/lib"
    GCC_64="$GCC_INSTALL_PREFIX/lib64"

    GCC_LIBS=(
        "libgcc_s.so.1"
    )

    install -d "${ED}/usr/lib"
    for lib in "${GCC_LIBS[@]}"; do
        ln -s "$GCC_32/$lib" "${ED}/usr/lib/$lib"
    done

    install -d "${ED}/usr/lib64"
    for lib in "${GCC_LIBS[@]}"; do
        ln -s "$GCC_64/$lib" "${ED}/usr/lib64/$lib"
    done
}
