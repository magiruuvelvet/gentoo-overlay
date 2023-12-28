EAPI=8

SLOT=0

inherit ecm kde.org

MY_PN="plasma-analyzer"

DESCRIPTION="Music Spectrum Analyzer for Plasma"
HOMEPAGE="https://github.com/hsitter/plasma-analyzer"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	SRC_URI=""
	KEYWORDS=""
	EGIT_REPO_URI="https://github.com/hsitter/${MY_PN}.git"
else
	MY_P="${MY_PN}-${PV}"
	SRC_URI="https://github.com/hsitter/${MY_PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
	S="${WORKDIR}/${MY_P}"
fi

IUSE=""

DEPEND="
	kde-frameworks/plasma
	media-libs/libpulse
"
RDEPEND="
	${DEPEND}
	media-sound/pulseaudio
"
