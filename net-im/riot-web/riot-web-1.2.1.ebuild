EAPI=7

DESCRIPTION="A glossy Matrix collaboration client for the desktop."

SRC_URI="https://packages.riot.im/debian/pool/main/r/riot-web/riot-web_${PV}_amd64.deb"
SLOT="0"
KEYWORDS="amd64"

BDEPEND="
    app-arch/tar
    app-arch/xz-utils
"

src_unpack() {
    unpack "${A}"
    mkdir "${S}"

    # ar p *.deb data.tar.xz | tar xJ -C "${S}"    
    tar xJf data.tar.xz -C "${S}"
}

src_install() {
    cp -r "${S}/"* "${D}/"
}
