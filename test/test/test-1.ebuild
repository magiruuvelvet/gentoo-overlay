# meta ebuild to check some stuff

EAPI=7
SLOT="0"
KEYWORDS="amd64 x86"

inherit llvm multilib multilib-minimal

src_unpack() {
    mkdir "$S"
}

# src_configure() {
#     :
# }

multilib_src_configure() {
    echo "$(tc-getCXX)"
    echo "$(tc-getBUILD_CXX)"

    echo "$(tc-getPKG_CONFIG)"

    echo "$PATH"
    echo "$LD_LIBRARY_PATH"
}

src_install() {
    # exit with an error to avoid merging an empty package
    exit 1
}
