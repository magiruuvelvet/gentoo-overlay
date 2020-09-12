EAPI=7

inherit cmake

DESCRIPTION="A modern, C++-native, header-only, test framework for unit-tests, TDD and BDD"
HOMEPAGE="https://github.com/catchorg/Catch2"
SRC_URI="https://github.com/catchorg/Catch2/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSL-1.0"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

S=${WORKDIR}/Catch2-${PV}

src_configure() {
    local mycmakeargs=(
        -DCATCH_USE_VALGRIND=OFF
        -DCATCH_BUILD_TESTING=OFF
        -DCATCH_BUILD_EXAMPLES=OFF
        -DCATCH_BUILD_EXTRA_TESTS=OFF
        -DCATCH_ENABLE_COVERAGE=OFF
        -DCATCH_ENABLE_WERROR=OFF
        -DCATCH_INSTALL_DOCS=OFF
        -DCATCH_INSTALL_HELPERS=OFF
    )

    cmake_src_configure
}

src_compile() {
    cmake_src_compile
}

src_install() {
    cmake_src_install
}
