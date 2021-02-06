EAPI=7

inherit llvm

DESCRIPTION="binutils aliases for LLVM"
LICENSE="MIT"

SLOT="0"
KEYWORDS="*"
IUSE=""

RDEPEND="
    sys-devel/llvm
"

LLVM_MAX_SLOT=11

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

create_binutil_symlink() {
    LLVM_PATH="$(get_llvm_prefix "${LLVM_MAX_SLOT}")"
    LLVM_BIN_UTIL="$LLVM_PATH/bin/llvm-"

    ln -s "${LLVM_BIN_UTIL}${1}"    "${ED}/usr/bin/${1}"
    ln -s "${LLVM_BIN_UTIL}${1}"    "${ED}/usr/bin/x86_64-pc-linux-${1}"
}

src_install() {
    insinto /usr/bin

    # utils
    create_binutil_symlink addr2line
    create_binutil_symlink ar
    create_binutil_symlink cxxfilt
    create_binutil_symlink dwp
    create_binutil_symlink nm
    create_binutil_symlink objcopy
    create_binutil_symlink objdump
    create_binutil_symlink ranlib
    create_binutil_symlink readelf
    create_binutil_symlink size
    create_binutil_symlink strings
    create_binutil_symlink strip

    # miscs
    install -m755 "${FILESDIR}/nm-demangle" "${ED}/usr/bin/"
    install -m755 "${FILESDIR}/strings-demangle" "${ED}/usr/bin/"

    # c++filt alias
    ln -s cxxfilt "${ED}/usr/bin/c++filt"

    # linker
    ln -s ld.lld "${ED}/usr/bin/ld"
}
