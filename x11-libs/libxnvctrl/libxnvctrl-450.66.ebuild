EAPI=7

inherit eutils multilib-minimal

DESCRIPTION="Standalone libXNVCtrl from nvidia-settings"
HOMEPAGE="https://github.com/NVIDIA/nvidia-settings"
LICENSE=""
SLOT=0
KEYWORDS="amd64 x86"
SRC_URI="https://github.com/NVIDIA/nvidia-settings/archive/${PV}.tar.gz"

RDEPEND="
    x11-drivers/nvidia-drivers[${MULTILIB_USEDEP}]
"
DEPEND="
    ${RDEPEND}
"

S="${WORKDIR}/nvidia-settings-${PV}/src/libXNVCtrl"

multilib_src_compile() {
    cp -r ../libXNVCtrl/* .
    emake
}

multilib_src_install() {
    myinstall() {
        insinto /usr/$(get_libdir)
        doins "${S}/../libXNVCtrl-${MULTILIB_ABI_FLAG}.${ABI}/_out/Linux_x86_64/libXNVCtrl.a"
    }
    multilib_foreach_abi myinstall

    insinto /usr/include/NVCtrl
    doins "${S}/NVCtrl.h"
    doins "${S}/NVCtrlLib.h"
}
