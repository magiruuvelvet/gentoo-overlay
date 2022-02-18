EAPI=7

LLVM_MAX_SLOT=11

inherit cmake llvm

MY_PV="${PV//_/-}"
MY_P="ldc-${MY_PV}-src"
SRC_URI="https://github.com/ldc-developers/ldc/releases/download/v${MY_PV}/${MY_P}.tar.gz"
S=${WORKDIR}/${MY_P}

DESCRIPTION="LLVM D Compiler"
HOMEPAGE="https://github.com/ldc-developers/ldc"
KEYWORDS="amd64"
LICENSE="BSD"
SLOT="0"

RDEPEND="sys-devel/llvm sys-libs/llvm-libunwind"
BDEPEND="dev-lang/ldc2"
DEPEND="${RDEPEND}"

PATCHES="
    ${FILESDIR}/llvm-runtime-patches.patch
    ${FILESDIR}/glibc-add-missing-definitions.patch
"

src_configure() {
    local mycmakeargs=(
        -DD_VERSION=2
        -DCMAKE_INSTALL_PREFIX=/usr
        -DLIB_SUFFIX=64
        -DD_COMPILER="ldmd2"
        -DLDC_WITH_LLD=OFF
        -DLDC_INSTALL_LTOPLUGIN=OFF
        -DBUILD_SHARED_LIBS=BOTH
        -DMULTILIB=OFF
    )

    cmake_src_configure
}

src_install() {
    cmake_src_install

    rm -rf "${ED}"/usr/share/bash-completion
    rm -rf "${ED}"/etc/bash_completion.d
}
