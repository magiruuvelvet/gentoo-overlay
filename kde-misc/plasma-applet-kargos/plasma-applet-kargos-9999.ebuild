EAPI=8

inherit ecm kde.org git-r3

DESCRIPTION="KDE Plasma port of GNOME Argos and OSX BitBar"
HOMEPAGE="https://github.com/sanniou/kargos6"
EGIT_REPO_URI="https://github.com/sanniou/kargos6"
SLOT=0
KEYWORDS="*"

PLASMOID_NAME="org.kde.kargos"

S="${WORKDIR}/plasma-applet-kargos-${PV}"

DEPEND="
    kde-plasma/plasma-workspace:6
"
RDEPEND="${DEPEND}"
