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
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-master/cmake-d"

PATCHES="
    ${FILESDIR}/fix-use-of-generic-name.patch
"
