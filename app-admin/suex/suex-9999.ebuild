##
## WARNING: DON'T USE IN PRODUCTION AND UNINSTALL AFTER YOU FINISHED YOUR EXPERIMENTS!!
## HIGHLY EXPERIMENTAL
##

EAPI=7

inherit git-r3 cmake

DESCRIPTION="A complete re-implementation of OpenBSD's doas that's extremely more robust"

HOMEPAGE="https://github.com/lostutils/suex"
EGIT_REPO_URI="$HOMEPAGE"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

PATCHES="
    ${FILESDIR}/add-missing-headers.patch
"

IUSE="-man-pages -clang-tidy"

RDEPEND="
    sys-libs/pam
    dev-libs/re2
    dev-libs/elfutils
"
DEPEND="${RDEPEND}"

BDEPEND="
    man-pages? ( app-text/ronn )
    clang-tidy? ( sys-devel/clang )
"
