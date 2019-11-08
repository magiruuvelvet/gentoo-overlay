EAPI=7

inherit llvm

DESCRIPTION="compat aliases for clang"
LICENSE="MIT"

SLOT="0"
KEYWORDS="*"
IUSE=""

RDEPEND="
    sys-devel/clang
"

LLVM_MAX_SLOT=9

src_unpack() {
    mkdir -p "${S}"
}

src_install() {
    insinto /usr/bin

    LLVM_PATH="$(get_llvm_prefix "${LLVM_MAX_SLOT}")"

    ln -s "$LLVM_PATH/bin/clang-cpp"    "${ED}/usr/bin/cpp"
    ln -s "$LLVM_PATH/bin/clang"        "${ED}/usr/bin/cc"
    ln -s "$LLVM_PATH/bin/clang++"      "${ED}/usr/bin/c++"

    # assembler
    ln -s "/opt/gnu/bin/as"             "${ED}/usr/bin/as"
}
