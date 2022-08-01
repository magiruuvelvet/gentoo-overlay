# Copyright 1999-2022 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit qmake-utils

DESCRIPTION="Qt5 YouTube Client"
HOMEPAGE="http://flavio.tordini.org/minitube"

if [[ ${PV} == 9999 ]];then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/flaviotordini/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/flaviotordini/${PN}/archive/${PV}.tar.gz ->
${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="debug download"

DEPEND="dev-qt/qtgui:5
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtnetwork:5
	dev-qt/qtdeclarative:5
	dev-qt/qtsql:5[sqlite]
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	dev-qt/qtimageformats:5
	dev-qt/qtsingleapplication[qt5(+),X]
	media-video/mpv[libmpv]
"
RDEPEND="${DEPEND}"

PATCHES="
	${FILESDIR}/mpv-0.34-api-changes.patch
"

src_prepare() {
	sed -i \
		's|include(src/qtsingleapplication/qtsingleapplication.pri)|CONFIG += qtsingleapplication|g' \
		${PN}.pro || die "Failed to unbundle qtsingleapplication"

	# Enable video downloads. Bug #491344
	use download && { echo "DEFINES += APP_DOWNLOADS" >> ${PN}.pro; }
	echo "DEFINES += APP_GOOGLE_API_KEY=${MINITUBE_GOOGLE_API_KEY}" >> ${PN}.pro

	default
}

src_configure() {
	eqmake5
}

src_install() {
	emake INSTALL_ROOT="${D}" install
}

pkg_postinst() {
	elog ""
	elog "Since version 2.4, you need to generate a Google API Key to use"
	elog "with this application. Please head over to"
	elog "https://console.developers.google.com/ and"
	elog "https://github.com/flaviotordini/minitube/blob/master/README.md"
	elog "for more information. Once you have generated your key,"
	elog "please put it in QSettings key \"googleApiKey\", e.g.:"
	elog "# echo 'googleApiKey=YourKeyHere' >> \"\${HOME}/.config/Flavio Tordini/Minitube.conf\""
	elog ""

	if use download; then
		elog "You activated the 'download' USE flag. This allows you to"
		elog "download videos from youtube, which might violate the youtube"
		elog "terms-of-service (TOS) in some legislations. If downloading"
		elog "youtube-videos is not allowed in your legislation, please"
		elog "disable the 'download' use flag. For details on the youtube TOS,"
		elog "see http://www.youtube.com/t/terms"
	fi
}
