EAPI=7

inherit cmake-utils

DESCRIPTION="cmake for D2"
HOMEPAGE="https://github.com/dcarp/cmake-d"

SRC_URI="https://github.com/dcarp/cmake-d/archive/master.zip -> ${P}.zip"
KEYWORDS="**"

LICENSE="MIT"
SLOT="0"
IUSE=""

RDEPEND="dev-util/cmake"
DEPEND="${RDEPEND}
    app-text/dos2unix
"

S="${WORKDIR}/${PN}-master/cmake-d"

PATCHES="
    ${FILESDIR}/fix-use-of-generic-name.patch
    ${FILESDIR}/dont-use-o3-for-release.patch
"

src_prepare() {
    elog "converting line endings..."
    find "${S}" -type f -exec dos2unix {} \;

    cmake-utils_src_prepare
}
