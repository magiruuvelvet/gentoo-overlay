EAPI=7

inherit eutils

SRC_URI="https://github.com/NVIDIA/nvidia-docker/archive/v${PV}.tar.gz -> nvidia-docker-${PV}.tar.gz"

SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND="
    >=nvidia-docker/nvidia-container-runtime-2.0.0
"

src_compile() {
    : # do nothing
}

src_install() {
    install -d "${D}"/usr/bin
    install -m755 nvidia-docker "${D}"/usr/bin/nvidia-docker

    install -d "${D}"/etc/docker
    install -m644 daemon.json "${D}"/etc/docker/daemon.json
}
