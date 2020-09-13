EAPI=7

DESCRIPTION="NVIDIA PRIME offloading utilities"

LICENSE=""
SLOT="0"
KEYWORDS="*"
IUSE="+compat +udev"

RDEPEND="
    x11-drivers/nvidia-drivers[X,libglvnd]
    media-libs/mesa[video_cards_intel,X,libglvnd,egl]
    x11-base/xorg-server[libglvnd]
    media-libs/vulkan-loader[X,layers]
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
#     mkdir -p "${ED}/usr/bin"
#     cp "${FILESDIR}/primerun" "${ED}/usr/bin/"
#     cp "${FILESDIR}/primerun-revert" "${ED}/usr/bin/"
#     cp "${FILESDIR}/nvidia-prime-status" "${ED}/usr/bin/"
    insinto /usr/bin
    dobin "${FILESDIR}/primerun"
    dobin "${FILESDIR}/primerun-revert"
    dobin "${FILESDIR}/nvidia-prime-status"

    # install legacy run commands as an alias to primerun (optirun and primusrun)
    if usex compat; then
        ln -s primerun "${ED}/usr/bin/primusrun"
        ln -s primerun "${ED}/usr/bin/optirun"
    fi

    # install bumblebee udev rule which handles /dev/nvidia* files
    if usex udev; then
        mkdir -p "${ED}/lib/udev/rules.d"
        cp "${FILESDIR}/99-nvidia-prime-dev.rules" "${ED}/lib/udev/rules.d/"
    fi
}
