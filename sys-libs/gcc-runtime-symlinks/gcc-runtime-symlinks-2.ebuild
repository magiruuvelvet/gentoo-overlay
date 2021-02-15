EAPI=7

DESCRIPTION="compat symlinks to find GCC runtime libraries"
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
        "libgomp.so.1"
        "libatomic.so.1"
        "libstdc++.so.6"
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

pkg_postinst() {
    elog "This package is obsolete. Please use the portage-hook-ctrl to fix individual"
    elog "packages which depend on the GCC runtime libraries on a case-by-case basis."
    elog "If the package is open-source, use static-gnu-runtime.conf to link the libraries"
    elog "statically. Otherwise make a LD_LIBRARY_PATH wrapper scripts or if the application"
    elog "already reads libraries from a specific location, make symlinks inside there."
}
