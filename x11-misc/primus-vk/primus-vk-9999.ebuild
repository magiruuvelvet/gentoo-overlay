EAPI=7

inherit git-r3

DESCRIPTION="Vulkan GPU-offloading layer"
HOMEPAGE="https://github.com/felixdoerre/primus_vk"
SRC_URI=""
EGIT_REPO_URI="https://github.com/felixdoerre/primus_vk.git"
EGIT_BRANCH="master"

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

src_compile() {
    local BASE_FLAGS_64='-DNV_DRIVER_PATH=\"/usr/lib64/libGLX_nvidia.so.0\"'
    local BASE_FLAGS_32='-DNV_DRIVER_PATH=\"/usr/lib/libGLX_nvidia.so.0\"'

    # compile 64-bit version
    emake \
        CFLAGS="${CFLAGS} ${BASE_FLAGS_64}" \
        CXXFLAGS="${CXXFLAGS} ${BASE_FLAGS_64}"
    mv libprimus_vk.so libprimus_vk.so64
    mv libnv_vulkan_wrapper.so libnv_vulkan_wrapper.so64

    # compile 32-bit version
    emake CC="${CC} -m32" CXX="${CXX} -m32" \
        CFLAGS="${CFLAGS} ${BASE_FLAGS_32}" \
        CXXFLAGS="${CXXFLAGS} ${BASE_FLAGS_32}"
    mv libprimus_vk.so libprimus_vk.so32
    mv libnv_vulkan_wrapper.so libnv_vulkan_wrapper.so32
}

src_install() {
    # install 64-bit libraries
    mkdir -p "${ED}/usr/lib64"
    cp libprimus_vk.so64 "${ED}/usr/lib64/libprimus_vk.so.1"
    cp libnv_vulkan_wrapper.so64 "${ED}/usr/lib64/libnv_vulkan_wrapper.so.1"
    ln -s libnv_vulkan_wrapper.so.1 "${ED}/usr/lib64/libnv_vulkan_wrapper.so"

    # install 32-bit libraries
    mkdir -p "${ED}/usr/lib"
    cp libprimus_vk.so32 "${ED}/usr/lib/libprimus_vk.so.1"
    cp libnv_vulkan_wrapper.so32 "${ED}/usr/lib/libnv_vulkan_wrapper.so.1"
    ln -s libnv_vulkan_wrapper.so.1 "${ED}/usr/lib/libnv_vulkan_wrapper.so"

    # install vulkan icd and implicit layer json
    mkdir -p "${ED}/etc/vulkan/icd.d"
    cp "${FILESDIR}/nv_vulkan_wrapper.json" "${ED}/etc/vulkan/icd.d/"
    mkdir -p "${ED}/etc/vulkan/implicit_layer.d"
    cp primus_vk.json "${ED}/etc/vulkan/implicit_layer.d/"

    # install launcher scripts
    mkdir -p "${ED}/usr/bin"
    cp "${FILESDIR}/pvkrun" "${ED}/usr/bin/pvkrun"
    chmod +x "${ED}/usr/bin/pvkrun"
    cp "${FILESDIR}/pvkoptirun" "${ED}/usr/bin/pvkoptirun"
    chmod +x "${ED}/usr/bin/pvkoptirun"
}
