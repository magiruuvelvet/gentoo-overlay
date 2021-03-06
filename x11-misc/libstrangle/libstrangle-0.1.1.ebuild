EAPI=7

HOMEPAGE="https://gitlab.com/torkel104/libstrangle"
SRC_URI="${HOMEPAGE}/-/archive/${PV}/libstrangle-${PV}.tar.gz"

LICENSE="GPL3"
SLOT="0"
KEYWORDS="amd64 x86"

# TODO: opengl vulkan useflags
ISUE=""

PATCHES="
    ${FILESDIR}/remove-hardcoded-compiler.patch
"

src_compile() {
    emake
}

src_install() {
    cd build

    mkdir -p "${ED}/usr/lib"
    mkdir -p "${ED}/usr/lib64"
    mkdir -p "${ED}/usr/share/vulkan/implicit_layer.d"

    cp libstrangle32.so "${ED}/usr/lib/libstrangle.so"
    cp libstrangle32_nodlsym.so "${ED}/usr/lib/libstrangle_nodlsym.so"
    cp libstrangle_vk32.so "${ED}/usr/lib/libstrangle_vk.so"

    cp libstrangle64.so "${ED}/usr/lib64/libstrangle.so"
    cp libstrangle64_nodlsym.so "${ED}/usr/lib64/libstrangle_nodlsym.so"
    cp libstrangle_vk64.so "${ED}/usr/lib64/libstrangle_vk.so"

    mkdir -p "${ED}/usr/bin"
    cp ../src/strangle.sh "${ED}/usr/bin/strangle"
    cp ../src/vulkan/libstrangle_vk.json "${ED}/usr/share/vulkan/implicit_layer.d/"
}
