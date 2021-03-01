EAPI=7

inherit cmake git-r3

DESCRIPTION="LLDB's machine interface driver"
HOMEPAGE="https://github.com/lldb-tools/lldb-mi"
LICENSE="Apache-2.0"
SLOT=0
KEYWORDS="amd64 x86"

EGIT_REPO_URI="${HOMEPAGE}"

RDEPEND="
    dev-util/lldb
"
DEPEND="${RDEPEND}"
