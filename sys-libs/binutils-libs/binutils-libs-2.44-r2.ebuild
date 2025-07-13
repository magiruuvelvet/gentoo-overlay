EAPI=8

inherit multilib-minimal

DESCRIPTION="binutils stub for portage"
LICENSE="MIT"

SLOT="0/${PV}"
KEYWORDS="*"
IUSE="64-bit-bfd cet multitarget nls static-libs test"

src_unpack() {
    mkdir -p "${S}"
}
