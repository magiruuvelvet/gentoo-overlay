EAPI=7

inherit git-r3

EGIT_REPO_URI="https://github.com/google/ios-webkit-debug-proxy"

SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="
    app-pda/libimobiledevice
    app-pda/usbmuxd
"

src_configure() {
    NOCONFIGURE=true ./autogen.sh
    econf --prefix=/usr CFLAGS="-std=gnu99 ${CFLAGS}"
}

src_compile() {
    emake
}

src_install() {
    emake DESTDIR="${D}" install
}
