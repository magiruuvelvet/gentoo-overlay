EAPI=7

EGO_PN="github.com/zyedidia/micro"
SRC_URI="https://${EGO_PN}/archive/v${PV}.tar.gz -> ${P}.tgz"

inherit golang-base

DESCRIPTION="A modern and intuitive terminal-based text editor"
HOMEPAGE="https://micro-editor.github.io"
RESTRICT="mirror"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"

IUSE="-plugin-linter"

BDEPEND=">=dev-lang/go-1.11"

G="${WORKDIR}/gopath"

pkg_pretend() {
    if has network-sandbox ${FEATURES} && [[ "${MERGE_TYPE}" != binary ]]; then
        ewarn
        ewarn "${CATEGORY}/${PN} requires 'network-sandbox' to be disabled in FEATURES"
        ewarn
        die "[network-sandbox] is enabled in FEATURES"
    fi
}

src_compile() {
    export GOPATH="${G}"
    local myldflags=( -s -w
        -X "main.Version=${PV}"
    )
    local mygoargs=(
        -v -work -x
        -asmflags "-trimpath=${S}"
        -gcflags "-trimpath=${S}"
        -ldflags "${myldflags[*]}"
    )
    go build "${mygoargs[@]}" ./cmd/micro || die
}

src_test() {
    go test -v ./cmd/micro || die
}

src_install() {
    dobin micro
    dodoc runtime/help/*.md

    insinto /usr/share/micro
    doins -r runtime/{colorschemes,plugins,syntax}

    if ! use plugin-linter; then
        rm -r "${ED}/usr/share/micro/plugins/linter"
    fi

    # default global configuration for every user
    # users must overwrite this environment variable in their own profile
	newenvd - "99editor-micro" <<-_EOF_
		MICRO_CONFIG_HOME=/etc/micro
	_EOF_

    mkdir -p "${ED}/etc/micro"
}

pkg_postinst() {
    env-update
}

pkg_postrm() {
    env-update
}
