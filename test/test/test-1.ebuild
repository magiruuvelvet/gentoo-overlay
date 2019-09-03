# meta ebuild to check some stuff

EAPI=7
SLOT="0"
KEYWORDS="amd64"

inherit llvm

src_unpack() {
    mkdir "$S"
}

src_configure() {
    :
}

src_install() {
    # exit with an error to avoid merging an empty package
    exit 1
}
