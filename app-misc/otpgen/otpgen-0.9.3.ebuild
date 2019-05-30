# TODO: unit test use flag

EAPI=7

SRC_URI="https://gitlab.com/magiruuvelvet/OTPGen/-/archive/v${PV}/OTPGen-v${PV}.tar.gz -> otpgen-${PV}.tar.gz"

DESCRIPTION="Multi-purpose OTP token generator. Supports TOTP, HOTP, Authy and Steam."
LICENSE="BSD-2-Clause"

SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="
    dev-util/cmake
"

RDEPEND="
    dev-qt/qtcore
    app-crypt/libsecret
    sys-libs/zlib
"

src_unpack() {
    unpack ${A}
    cd "${S}/.."
    mv OTPGen-v${PV} ${PN}-${PV}
}

src_configure() {
    mkdir -p build && cd build
    cmake \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_INSTALL_PREFIX=/usr \
        -DBUNDLED_ZLIB=OFF \
        -DBUNDLED_CRYPTOPP=ON \
        -DCRYPTOPP_NATIVE_ARCH=ON \
        -DUNIT_TESTING=ON \
      ..
}

src_compile() {
    cd build
    emake
}

src_install() {
    cd build
    emake install DESTDIR="${D}"
}
