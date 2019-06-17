# meta ebuild to check some stuff

EAPI=7
SLOT="0"
KEYWORDS="amd64"

inherit llvm

src_unpack() {
    mkdir "/var/tmp/portage/test/test-1/work/test-1"
}

src_configure() {
    # check default LLVM version being used
    # needed to remove llvm-9999 and install out of place in /opt for RPCS3
    # to avoid bricking my install
    # please just use LLVM 8 stable as default
    echo $(get_llvm_prefix)
}

src_install() {
    # exit with an error to avoid merging an empty package
    exit 1
}
