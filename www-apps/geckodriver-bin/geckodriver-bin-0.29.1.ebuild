EAPI=7

DESCRIPTION="GeckoDriver for Firefox-based Browsers"
HOMEPAGE="https://github.com/mozilla/geckodriver"
SRC_URI="amd64? ( https://github.com/mozilla/geckodriver/releases/download/v0.29.1/geckodriver-v${PV}-linux64.tar.gz -> ${P}.linux64.tar.gz )"

LICENSE="Mozilla"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="bindist mirror strip"

S="${WORKDIR}"
QA_PREBUILT="usr/bin/geckodriver"

src_install() {
    dobin geckodriver
}
