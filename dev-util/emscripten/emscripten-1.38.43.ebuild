EAPI=7

DESCRIPTION="Emscripten: An LLVM-to-Web Compiler"
HOMEPAGE="https://github.com/emscripten-core/emscripten"

SRC_URI="https://github.com/emscripten-core/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~x86"

LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND="
    sys-devel/llvm[llvm_targets_WebAssembly]
    sys-devel/clang[llvm_targets_WebAssembly]
    sys-devel/lld
    dev-util/binaryen
    dev-lang/python
    net-libs/nodejs
    dev-util/cmake
"

PATCHES="
    $FILESDIR/disable-llvm-version-check.patch
    $FILESDIR/use-system-lld.patch
    $FILESDIR/use-gnu-mode-when-building-system-libraries.patch
    $FILESDIR/embuilder-strict-mode-fixes.patch
"

src_install() {
    insinto /opt/emscripten
    cp -rp "${S}/." "${ED}/opt/emscripten"

    insinto /usr/bin
    for tool in em++ em-config emar emcc emcmake emconfigure emmake emranlib emrun emscons; do
        ln -s "/opt/emscripten/$tool" "${ED}/usr/bin/$tool"
    done
}
