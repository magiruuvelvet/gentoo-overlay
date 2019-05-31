# FIXME: get the patched runc to build instead of using a prebuilt binary from Arch Linux

EAPI=7

inherit eutils

_runtime_commit="03af0a80dbcbcfa09a828cde46151749bee2480e"
_runc_commit="2b18fe1d885ee5083ef9f0838fee39b62d653e30"
_runc_patch_commit="6635b4f0c6af3810594d2770f662f34ddc15b40d"
_runc_path="gopath/src/github.com/opencontainers/runc"

SRC_URI="
https://github.com/NVIDIA/nvidia-container-runtime/archive/runtime-v${PV}.tar.gz -> nvidia-container-runtime-${PV}.tar.gz
https://github.com/NVIDIA/nvidia-container-runtime/archive/${_runtime_commit}.zip -> nvidia-container-runtime-${_runtime_commit}.zip
https://github.com/opencontainers/runc/archive/${_runc_commit}.zip -> runc-${_runc_commit}.zip
"

SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="
    dev-lang/go
"

RDEPEND="
    >=nvidia-docker/libnvidia-container-1.0.2
"

src_unpack() {
    unpack ${A}
    mv nvidia-container-runtime-runtime-v${PV} "${S}"
}

src_prepare() {
    mkdir -p gopath/src
    ln -rTsf "${S}/hook/nvidia-container-runtime-hook" "gopath/src/nvidia-container-runtime-hook"

    # NOTE: go compiler complains, is the Go version too old or too new? or is gogcc required instead???
#     cd ../runc-${_runc_commit}
#     patch -Np1 < ${S}/../nvidia-container-runtime-${_runtime_commit}/runtime/runc/${_runc_patch_commit}/*
#     mkdir -p "${S}"/gopath/src/github.com/opencontainers
#     ln -rTsf "${S}/runc" "${S}/${_runc_path}"
#     ln -s "${S}/../runc-${_runc_commit}/vendor" "${S}/../runc-${_runc_commit}/vendor/src"
#     ln -s "${S}/../runc-${_runc_commit}/" "${S}/../runc-${_runc_commit}/vendor/github.com/opencontainers/runc"

    eapply_user
}

src_compile() {
    GOPATH="${S}/gopath" go install -buildmode=pie -ldflags " -s -w -extldflags=-Wl,-z,now,-z,relro" "nvidia-container-runtime-hook"

#    cd ../runc-${_runc_commit}
#    GOPATH="${S}/../runc-${_runc_commit}:${S}/../runc-${_runc_commit}/vendor" EXTRA_LDFLAGS="-extldflags=-Wl,-z,now,-z,relro" make
}

src_install() {
    install -D -m755 "${S}/gopath/bin/nvidia-container-runtime-hook" "${D}/usr/bin/nvidia-container-runtime-hook"
#    install -D -m755 "${S}/${_runc_path}/runc" "${D}/usr/bin/nvidia-container-runtime"
    install -D -m755 "${FILESDIR}/nvidia-container-runtime" "${D}/usr/bin/nvidia-container-runtime"
    install -D -m644 "${S}/hook/config.toml.centos" "${D}/etc/nvidia-container-runtime/config.toml"
    install -D -m644 "${S}/LICENSE" "${D}/usr/share/licenses/${PN}/LICENSE"
}
