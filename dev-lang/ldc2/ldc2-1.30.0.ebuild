EAPI=7

ldc2_commit=501c6577fa052c3b8d69373105aec1c07574c6e5
phobos_commit=63090119d71f9795744618c7386b7d6f29454a15

LLVM_MAX_SLOT=15

inherit cmake llvm

MY_PV="${PV//_/-}"
MY_P="ldc-${MY_PV}-src"

#SRC_URI="https://github.com/ldc-developers/ldc/releases/download/v${MY_PV}/${MY_P}.tar.gz"
#S="${WORKDIR}/${MY_P}"

SRC_URI="
    https://github.com/ldc-developers/ldc/archive/${ldc2_commit}.zip -> ${MY_P}-${ldc2_commit}.zip
    https://github.com/ldc-developers/phobos/archive/${phobos_commit}.zip -> ${MY_P}-phobos-${phobos_commit}.zip
"
S="${WORKDIR}/ldc-${ldc2_commit}"

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
"

src_unpack() {
    default

    rmdir "${S}/runtime/phobos"
    mv "${WORKDIR}/phobos-${phobos_commit}" "${S}/runtime/phobos"
}

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
