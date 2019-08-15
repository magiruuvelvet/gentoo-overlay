EAPI=7

inherit multilib-minimal

DESCRIPTION="binutils stub for portage"
LICENSE="MIT"

SLOT="0/${PV}"
KEYWORDS="*"
IUSE="64-bit-bfd multitarget nls static-libs"

src_unpack() {
    mkdir -p "${S}"
}
