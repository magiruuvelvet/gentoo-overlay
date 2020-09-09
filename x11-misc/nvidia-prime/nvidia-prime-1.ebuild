EAPI=7

DESCRIPTION="NVIDIA PRIME offloading utilities"

LICENSE=""
SLOT="0"
KEYWORDS="*"
IUSE=""

RDEPEND="
    x11-drivers/nvidia-drivers[libglvnd]
    media-libs/mesa[video_cards_intel,egl]
    x11-base/xorg-server[libglvnd]
    media-libs/vulkan-loader
"
DEPEND="
    ${RDEPEND}
    virtual/opengl
    !x11-misc/primus
    !x11-misc/primus-vk
    !x11-misc/bumblebee
"

S="${WORKDIR}"

src_install() {
    mkdir -p "${ED}/usr/bin"
    cp "${FILESDIR}/primerun" "${ED}/usr/bin/"
    ln -s primerun "${ED}/usr/bin/primusrun"
    ln -s primerun "${ED}/usr/bin/optirun"

    mkdir -p "${ED}/lib/udev/rules.d"
    cp "${FILESDIR}/99-nvidia-prime-dev.rules" "${ED}/lib/udev/rules.d/"
}
