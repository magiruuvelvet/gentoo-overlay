EAPI=7

KEYWORDS="*"
SLOT="0"

# avoid accidental removal of rpcs3 dependencies
DEPEND="
    >=dev-qt/qtcore-5.12.2
    media-libs/glew
    media-libs/vulkan-loader
    dev-libs/libevdev
"
