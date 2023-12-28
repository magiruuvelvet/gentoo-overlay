EAPI=8

inherit git-r3 ecm kde.org

DESCRIPTION="Plasma 5 applet in order to show window buttons in your panels"
HOMEPAGE="https://gitlab.com/agurenko/plasma-applet-thermal-monitor"

KEYWORDS=""
EGIT_REPO_URI="$HOMEPAGE"

SLOT=0
IUSE=""

DEPEND="
    kde-plasma/libplasma
    kde-frameworks/frameworkintegration
    sys-apps/lm-sensors
"
RDEPEND="${DEPEND}"
