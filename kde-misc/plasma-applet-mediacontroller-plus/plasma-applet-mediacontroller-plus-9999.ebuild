EAPI=7

inherit ecm kde.org git-r3

DESCRIPTION="Modified version of mediacontroller plasma5 widget"
HOMEPAGE="https://github.com/ismailof/mediacontroller_plus"
EGIT_REPO_URI="https://github.com/ismailof/mediacontroller_plus"
SLOT=0
KEYWORDS="*"

PLASMOID_NAME="org.kde.plasma.mediacontroller_plus"

DEPEND="
    kde-plasma/plasma-workspace
"
RDEPEND="${DEPEND}"

PATCHES="
    ${FILESDIR}/fix-plugin-metadata.patch
"
