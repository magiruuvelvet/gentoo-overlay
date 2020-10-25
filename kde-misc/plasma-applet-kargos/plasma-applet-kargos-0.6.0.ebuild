EAPI=7

inherit ecm kde.org

DESCRIPTION="KDE Plasma port of GNOME Argos and OSX BitBar"
HOMEPAGE="https://github.com/lipido/kargos"
SRC_URI="https://github.com/lipido/kargos/archive/v${PV}.tar.gz"
SLOT=0
KEYWORDS="*"

PLASMOID_NAME="org.kde.kargos"

S="${WORKDIR}/kargos-${PV}"

DEPEND="
    kde-plasma/plasma-workspace
"
RDEPEND="${DEPEND}"
