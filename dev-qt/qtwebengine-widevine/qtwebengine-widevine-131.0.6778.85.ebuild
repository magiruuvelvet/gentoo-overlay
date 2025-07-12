# Based on www-plugins/chrome-binary-plugins and an old version of this ebuild
# mixed together into one ebuild to support recent Chrome packages.

EAPI=7

inherit unpacker

DESCRIPTION="A browser plugin designed for the viewing of premium video content"
HOMEPAGE="https://www.google.com/chrome"

LICENSE="google-chrome"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
RESTRICT="mirror strip"

MY_PN="google-chrome-stable"
MY_PV=${PV}-1
MY_P="${MY_PN}_${MY_PV}"

SRC_URI="https://dl.google.com/linux/chrome/deb/pool/main/g/${MY_PN}/${MY_P}_amd64.deb"

DEPEND="dev-qt/qtwebengine:5"
RDEPEND="${DEPEND}"

CHROMEDIR="opt/google/chrome"
S="${WORKDIR}/${CHROMEDIR}"
QA_PREBUILT="*"

src_install(){
    exeinto "/usr/$(get_libdir)/qt5/plugins/ppapi"
    doexe WidevineCdm/_platform_specific/linux_x64/libwidevinecdm*.so
}
