EAPI=7

inherit git-r3

DESCRIPTION="Vulkan GPU-offloading layer"
HOMEPAGE="https://github.com/felixdoerre/primus_vk"
SRC_URI=""
EGIT_REPO_URI="https://github.com/felixdoerre/primus_vk.git"
EGIT_BRANCH="preview_cleanup"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
    media-libs/vulkan-layers
    dev-util/vulkan-headers
    media-libs/vulkan-loader
    x11-drivers/nvidia-drivers
"
DEPEND="virtual/opengl"

PATCHES=(
    "${FILESDIR}"/gentoo-adjustments.patch
)

src_compile() {
    make
    patch -p1 < "${FILESDIR}/32-bit.patch"
    make
}

src_install() {
    mkdir -p "${ED}/usr/lib64"
    cp libprimus_vk.so "${ED}/usr/lib64/libprimus_vk.so.1"
    cp libnv_vulkan_wrapper.so "${ED}/usr/lib64/"

    mkdir -p "${ED}/usr/lib"
    cp libprimus_vk.so32 "${ED}/usr/lib/libprimus_vk.so.1"
    cp libnv_vulkan_wrapper.so32 "${ED}/usr/lib/libnv_vulkan_wrapper.so"

    mkdir -p "${ED}/etc/vulkan/icd.d"
    cp "${FILESDIR}/nv_vulkan_wrapper.json" "${ED}/etc/vulkan/icd.d/"

    mkdir -p "${ED}/etc/vulkan/implicit_layer.d"
    cp primus_vk.json "${ED}/etc/vulkan/implicit_layer.d/"

    mkdir -p "${ED}/usr/bin"
    cp pvkrun.in.sh "${ED}/usr/bin/pvkrun"
    chmod +x "${ED}/usr/bin/pvkrun"

    sed -i 's/primusrun/optirun/g' pvkrun.in.sh
    cp pvkrun.in.sh "${ED}/usr/bin/pvkoptirun"
    chmod +x "${ED}/usr/bin/pvkoptirun"
}
