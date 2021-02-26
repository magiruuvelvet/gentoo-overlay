EAPI=7

DESCRIPTION="Emscripten: An LLVM-to-WebAssembly Compiler"
HOMEPAGE="https://github.com/emscripten-core/emscripten"

SRC_URI="https://github.com/emscripten-core/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~x86"

LICENSE="MIT"
SLOT="2"
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
    ${FILESDIR}/${SLOT}-remove-unsupported-clang-option.patch
"

src_configure() {
    : # disable configure attempt
}

src_compile() {
    : # disable compile attempt, deletes all files in WORKDIR for some reason
}

src_install() {
    insinto /opt/emscripten
    cp -rp "${S}/." "${ED}/opt/emscripten"

    # remove excludes according to tools/install.py
    cd "${ED}/opt/emscripten"
    rm -r tests/third_party || true
    rm -r site || true
    rm -r node_modules || true
    rm Makefile || true

    # general cleanup
    rm -r tools/install.py || true
    rm -r .circleci || true
    rm -r .github || true
    rm .clang-format || true
    rm .editorconfig || true
    rm .eslintrc.yml || true
    rm .flake8 || true
    rm .gitattributes || true
    rm .gitignore || true
    rm .gitmodules || true
    rm .style.yapf || true
    rm *.bat || true # remove windows batch scripts
    rm package-lock.json || true
    rm package.json || true
    rm requirements-dev.txt || true

    insinto /usr/bin
    for tool in em++ em-config emar emcc emcmake emconfigure emmake emranlib emrun emscons; do
        ln -s "/opt/emscripten/$tool.py" "${ED}/usr/bin/$tool"
    done
}
