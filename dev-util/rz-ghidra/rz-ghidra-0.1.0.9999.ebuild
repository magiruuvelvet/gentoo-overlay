EAPI=7

inherit cmake

rz_ghidra_version="7d6b17348f592d52665b457acddeceaf120e3e71"
ghidra_version="d53e1a0c52b2c7757f55befe44f8584eb53dc448"

DESCRIPTION="Deep ghidra decompiler and sleigh disassembler integration for rizin"
HOMEPAGE="https://github.com/rizinorg/rz-ghidra"
LICENSE="LGPL-3.0"
SLOT=0
KEYWORDS="amd64 x86"
IUSE="cutter-plugin tools"

SRC_URI="
    https://github.com/rizinorg/rz-ghidra/archive/${rz_ghidra_version}.zip -> ${P}.zip
    https://github.com/rizinorg/ghidra/archive/${ghidra_version}.zip -> ${P}-ghidra.zip
"

DEPEND="
    dev-util/rizin
    dev-libs/pugixml
    cutter-plugin? ( dev-util/cutter )
"

S="${WORKDIR}/${PN}-${rz_ghidra_version}"

src_unpack() {
    unpack "${P}.zip"
    unpack "${P}-ghidra.zip"

    # move ghidra into source tree
    rmdir "${PN}-${rz_ghidra_version}/ghidra/ghidra"
    mv "ghidra-${ghidra_version}" \
        "${PN}-${rz_ghidra_version}/ghidra/ghidra"
}

src_configure() {
    local mycmakeargs=(
        -DUSE_SYSTEM_PUGIXML=ON
        -DBUILD_CUTTER_PLUGIN="$(usex "cutter-plugin")"
        -DBUILD_DECOMPILE_EXECUTABLE="$(usex "tools")"
        -DBUILD_DECOMPILE_CLI_EXECUTABLE="$(usex "tools")"
    )

    cmake_src_configure
}

pkg_postinst() {
    elog "If the plugin doesn't work or segfaults, try to symlink all files and folders found in"
    elog "'/usr/share/rizin/plugins/' into your home '~/.local/share/rizin/plugins/'."
    elog "The plugin has a bug where it can't find its own configuration for some reason."
    elog "    analysis_ghidra.so -> /usr/share/rizin/plugins/analysis_ghidra.so"
    elog "    asm_ghidra.so -> /usr/share/rizin/plugins/asm_ghidra.so"
    elog "    core_ghidra.so -> /usr/share/rizin/plugins/core_ghidra.so"
    elog "    rz_ghidra_sleigh -> /usr/share/rizin/plugins/rz_ghidra_sleigh"
}
