EAPI=8

inherit desktop xdg-utils

MY_PN="${PN/-bin/}"
MY_PV="0.2.3-a"

DESCRIPTION="Insomnium is a fast local API testing tool that is privacy-focused and 100% local. For testing GraphQL, REST, WebSockets and gRPC."
HOMEPAGE="https://archgpt.dev/insomnium"
SRC_URI="https://github.com/ArchGPT/${MY_PN}/releases/download/core@${MY_PV}/Insomnium.Core-${MY_PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"

RDEPEND=""

S="${WORKDIR}"

src_install() {
    insinto /opt/Insomnium
    doins -r Insomnium.Core-${MY_PV}/.
    fperms +x /opt/Insomnium/chrome{-sandbox,_crashpad_handler} \
        /opt/Insomnium/lib{EGL,ffmpeg,GLESv2,vk_swiftshader}.so \
        /opt/Insomnium/libvulkan.so.1 /opt/Insomnium/insomnium
    dobin "${FILESDIR}/insomnium"

    # instal desktop files and icons
    domenu "${FILESDIR}/insomnium.desktop"
    newicon "${FILESDIR}/icon.png" insomnium.png
    for size in 256 512; do
        newicon -s "$size" "${FILESDIR}/${size}x${size}.png" insomnium.png
    done
}

pkg_postinst() {
    xdg_desktop_database_update
}

pkg_postrm() {
    xdg_desktop_database_update
}
