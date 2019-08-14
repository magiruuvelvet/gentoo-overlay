EAPI=7

DESCRIPTION="binutils aliases for LLVM"
LICENSE="MIT"

SLOT="0"
KEYWORDS="*"
IUSE=""

RDEPEND="
    sys-devel/llvm
"

src_unpack() {
    mkdir -p "${S}"
}

# NOTE:
#
# llvm-as is not an as replacement!
# llvm doesn't provide gprof
# llvm doesn't provide a command line compatible as
# llvm doesn't seem to provide elfedit
#

src_install() {
    insinto /usr/bin

    for i in "${FILESDIR}"/*; do
        install -m755 "$i" "${ED}/usr/bin/"
    done

    ln -s c++filt "${ED}/usr/bin/cxxfilt"

    ln -s ld.lld "${ED}/usr/bin/ld"
}
