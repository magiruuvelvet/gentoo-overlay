# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
WX_GTK_VER="3.0"

inherit git-r3 autotools eutils toolchain-funcs wxwidgets

DESCRIPTION="Analyse your audio files by showing their spectrogram"
HOMEPAGE="http://www.spek-project.org/"
EGIT_REPO_URI="https://github.com/alexkay/spek.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="libav"

RDEPEND="
	libav? ( media-video/libav:= )
	!libav? ( media-video/ffmpeg:0= )
	x11-libs/wxGTK[X]
"
DEPEND="${RDEPEND}
	dev-util/intltool
	virtual/pkgconfig
	sys-devel/gettext
"

src_prepare() {
	eautoreconf
}
