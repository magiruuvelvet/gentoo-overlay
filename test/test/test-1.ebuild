# meta ebuild to check some stuff

EAPI=7
SLOT="0"
KEYWORDS="amd64 x86"

inherit llvm multilib multilib-minimal meson-multilib

src_unpack() {
    mkdir "$S"
}

# src_configure() {
#     :
# }

multilib_src_configure() {
    echo "tc-getCXX:              $(tc-getCXX)"
    echo "tc-getBUILD_CXX:        $(tc-getBUILD_CXX)"

    echo "tc-getPKG_CONFIG:       $(tc-getPKG_CONFIG)"
    echo "tc-getBUILD_PKG_CONFIG: $(tc-getBUILD_PKG_CONFIG)"

    echo "CBUILD:                 $(portageq envvar CHOST)"
    echo "CHOST:                  $(portageq envvar CBUILD)"

    echo "PATH: $PATH"
    echo "LD_LIBRARY_PATH: $LD_LIBRARY_PATH"

    # verify generated meson native files
    _meson_create_native_file
}

src_install() {
    # exit with an error to avoid merging an empty package
    exit 1
}
