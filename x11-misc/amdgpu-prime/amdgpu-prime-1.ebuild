EAPI=7

DESCRIPTION="AMD PRIME offloading utilities"

LICENSE=""
SLOT="0"
KEYWORDS="*"
IUSE="+compat"

RDEPEND="
    media-libs/mesa[video_cards_radeonsi,X]
    x11-base/xorg-server
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
    insinto /usr/bin
    dobin "${FILESDIR}/primerun"
    dobin "${FILESDIR}/primerun-revert"
    dobin "${FILESDIR}/amdgpu-prime-status"

    # install legacy run commands as an alias to primerun (optirun and primusrun)
    if usex compat; then
        ln -s primerun "${ED}/usr/bin/primusrun"
        ln -s primerun "${ED}/usr/bin/optirun"
    fi
}
