# 1. download official RPM from website
# 2. extract all RPMs and copy the actual program into /opt
# 3. install this package to get the icons, mime types and desktop entries

# most dependencies are bundled, but you need to install avahi for
# some components to work

# TODO: create ebuild for the entire thing and remove the version number everywhere
#       version number is in desktop entries and scripts

# the binary build from Gentoo depends on an old ICU version and ICU isn't slotted in Gentoo

EAPI=7

SRC_URI="https://storage.magiruuvelvet.gdn/ebuild/${P}.tar.gz"

SLOT="0"
KEYWORDS="*"
IUSE=""

RESTRICT="mirror"

S="${WORKDIR}"

src_install() {
    cp -r "${S}"/* "${D}"

    ln -s /opt/libreoffice6.4/program/soffice "${D}/usr/bin/libreoffice"
    rm "${D}/usr/bin/libreoffice6.4" # this launcher doesn't work
    ln -s /opt/libreoffice6.4/program/soffice "${D}/usr/bin/libreoffice6.4"
}
