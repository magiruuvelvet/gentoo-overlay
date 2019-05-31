# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

# NOTE by me: this package does not work and basically just downloads
# a bunch of docker images and does nothing but wasting bandwidth and
# your time
# checkout the nvidia-docker group of this repository instead :)

EAPI=7

DESCRIPTION="NVIDIA Docker"
HOMEPAGE="https://github.com/NVIDIA/nvidia-docker"
RESTRICT="fetch"
SRC_URI="nvidia-docker-${PV}.tar.gz"

LICENSE="NVIDIA CORPORATION"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	app-emulation/docker
"
RDEPEND="${DEPEND}"

# what is this portage, hardcoded package name + version inside work directory???
src_unpack() {
    unpack ${A}
    cd "${S}"
    mkdir nvidia-docker-${PV}
    mv usr etc nvidia-docker-${PV}/
}

src_install() {
    cp -R "${S}/"* "${D}/" || die "Install failed!"
    mv "${D}/usr/lib" "${D}/usr/lib64"
}
