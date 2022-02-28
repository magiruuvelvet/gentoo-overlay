# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Mediastreaming library for telephony application"
HOMEPAGE="https://gitlab.linphone.org/BC/public/mediastreamer2"
SRC_URI="https://github.com/BelledonneCommunications/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="alsa debug ffmpeg gsm jpeg matroska opengl opus pcap portaudio +pulseaudio qrcode speex resample theora tools +v4l vpx"
REQUIRED_USE="
	resample? ( speex )
	|| ( alsa portaudio pulseaudio )
	|| ( ffmpeg opengl v4l )"

RDEPEND="net-libs/bctoolbox
	net-libs/ortp
	net-libs/bzrtp
	alsa? ( media-libs/alsa-lib )
	ffmpeg? ( media-video/ffmpeg )
	gsm? ( media-sound/gsm )
	jpeg? ( media-libs/libjpeg-turbo )
	matroska? ( media-libs/bcmatroska2 )
	opengl? ( media-libs/glew:0
		x11-libs/libX11
		virtual/opengl )
	opus? ( media-libs/opus )
	pcap? ( net-libs/libpcap )
	portaudio? ( media-libs/portaudio )
	pulseaudio? ( media-sound/pulseaudio )
	qrcode? ( media-libs/zxing-cpp )
	speex? ( media-libs/speex
		media-libs/speexdsp )
	theora? ( media-libs/libtheora )
	v4l? ( media-libs/libv4l )
	vpx? ( media-libs/libvpx:= )"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

src_configure() {
	local mycmakeargs=(
		-DENABLE_ALSA="$(usex alsa)"
		-DENABLE_BV16=OFF
		-DENABLE_DEBUG_LOGS="$(usex debug)"
		-DENABLE_DOC=OFF
		-DENABLE_FFMPEG="$(usex ffmpeg)"
		-DENABLE_G726=OFF
		-DENABLE_G729=OFF
		-DENABLE_G729B_CNG=OFF
		-DENABLE_GL="$(usex opengl)"
		-DENABLE_GLX="$(usex opengl)"
		-DENABLE_GSM="$(usex gsm)"
		-DENABLE_JPEG="$(usex jpeg)"
		-DENABLE_MKV="$(usex matroska)"
		-DENABLE_OPUS="$(usex opus)"
		-DENABLE_PCAP="$(usex pcap)"
		-DENABLE_PORTAUDIO="$(usex portaudio)"
		-DENABLE_PULSEAUDIO="$(usex pulseaudio)"
		-DENABLE_QRCODE="$(usex qrcode)"
		-DENABLE_RESAMPLE="$(usex resample)"
		-DENABLE_SPEEX_CODEC="$(usex speex)"
		-DENABLE_SPEEX_DSP="$(usex speex)"
		-DENABLE_SRTP=OFF
		-DENABLE_STATIC=OFF
		-DENABLE_THEORA="$(usex theora)"
		-DENABLE_TOOLS="$(usex tools)"
		-DENABLE_UNIT_TESTS=OFF
		-DENABLE_V4L="$(usex v4l)"
		-DENABLE_VPX="$(usex vpx)"
		-DENABLE_ZRTP=ON
	)

	cmake_src_configure
}
