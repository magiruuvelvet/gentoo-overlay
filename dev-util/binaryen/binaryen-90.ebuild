EAPI=7

inherit cmake-utils

DESCRIPTION="Сompiler and toolchain infrastructure library for WebAssembly, written in C++"
HOMEPAGE="https://github.com/WebAssembly/binaryen"

if [[ ${PV} == 9999 ]]; then
    inherit git-r3
    EGIT_REPO_URI="https://github.com/WebAssembly/${PN}.git"
    EGIT_SUBMODULES=()
    KEYWORDS=""
else
    SRC_URI="https://github.com/WebAssembly/${PN}/archive/version_${PV}.tar.gz -> ${P}.tar.gz"
    KEYWORDS="~amd64 ~x86"
fi

LICENSE="Apache-2.0"
SLOT="0"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

CMAKE_MIN_VERSION="2.8.7"

S="${WORKDIR}/${PN}-version_${PV}"

PATCHES="
    ${FILESDIR}/disable-assertion-check.patch
    ${FILESDIR}/fix-link.patch
"

src_prepare() {
    sed -r -i \
        -e '/INSTALL.+src\/binaryen-c\.h/d' \
        CMakeLists.txt || die

    cmake-utils_src_prepare
}

src_configure() {
    local mycmakeargs=(
        -DBUILD_STATIC_LIB=OFF
        -DENABLE_WERROR=OFF
        -DBYN_ASSERTIONS_ENABLED=ON
        -DLLVM_ENABLE_DUMP=ON
    )

    cmake-utils_src_configure
}

src_install() {
    cmake-utils_src_install

    insinto "/usr/include/${PN}"
    doins "${S}"/src/*.h

    for hdir in asmjs emscripten-optimizer ir support; do
        insinto "/usr/include/${PN}/${hdir}"
        doins "${S}"/src/${hdir}/*.h
    done
}
