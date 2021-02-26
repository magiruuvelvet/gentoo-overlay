EAPI=7

DESCRIPTION="Emscripten: An LLVM-to-WebAssembly Compiler"
HOMEPAGE="https://github.com/emscripten-core/emscripten"

SRC_URI="https://github.com/emscripten-core/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~x86"

LICENSE="MIT"
SLOT="1"
IUSE="bin-symlink"

DEPEND="
    sys-devel/llvm[llvm_targets_WebAssembly]
    sys-devel/clang[llvm_targets_WebAssembly]
    sys-devel/lld
    dev-util/binaryen
    dev-lang/python
    net-libs/nodejs
    dev-util/cmake

    bin-symlink? ( !dev-util/emscripten:2 )
"

src_configure() {
    : # disable configure attempt
}

src_compile() {
    : # disable compile attempt, deletes all files in WORKDIR for some reason
}

src_install() {
    # allow side-by-side installation with version 2
    insinto /opt/emscripten-v${SLOT}
    cp -rp "${S}/." "${ED}/opt/emscripten-v${SLOT}"

    if use bin-symlink; then
        insinto /usr/bin
        for tool in em++ em-config emar emcc emcmake emconfigure emmake emranlib emrun emscons; do
            ln -s "/opt/emscripten-v${SLOT}/$tool.py" "${ED}/usr/bin/$tool"
        done
    fi
}
