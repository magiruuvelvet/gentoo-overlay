EAPI=7

inherit eutils #git-r3

#EGIT_REPO_URI="https://github.com/NVIDIA/libnvidia-container.git"
#EGIT_COMMIT="773b1954446b73921ce16919248c764ff62d29ad"
SRC_URI="
https://github.com/NVIDIA/libnvidia-container/archive/v${PV}.tar.gz -> libnvidia-container-${PV}.tar.gz
https://github.com/NVIDIA/nvidia-modprobe/archive/396.51.tar.gz -> nvidia-modprobe-396.51.tar.gz
https://sourceforge.net/projects/elftoolchain/files/Sources/elftoolchain-0.7.1/elftoolchain-0.7.1.tar.bz2
"

# NOTE:
# depends on gold linker when building with clang
# if you have gold disabled and don't want to rebuild llvm
# use the gcc compiler instead

SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="
    sys-devel/bmake
    sys-apps/lsb-release
"

RDEPEND="
    net-libs/libtirpc
    sys-libs/libcap
    sys-libs/libseccomp
"

DEPEND="${RDEPEND}"

PATCHES=(
    "${FILESDIR}/fix_rpc_flags.patch"
    "${FILESDIR}/fix_git_rev_unavail.patch"
)

src_unpack() {
    unpack ${A}
}

src_prepare() {
    patch Makefile < "${FILESDIR}/fix_rpc_flags.patch"
    patch mk/common.mk < "${FILESDIR}/fix_git_rev_unavail.patch"
    eapply_user

    # move files in place for make, ebuild doesn't allow downloading files from the internet :/
    mkdir -p deps/src/nvidia-modprobe-396.51
    mv ../nvidia-modprobe-396.51/* deps/src/nvidia-modprobe-396.51/
    touch deps/src/nvidia-modprobe-396.51/.download_stamp

    mkdir deps/src/elftoolchain-0.7.1
    mv ../elftoolchain-0.7.1/* deps/src/elftoolchain-0.7.1
    touch deps/src/elftoolchain-0.7.1/.download_stamp
}

src_compile() {
    emake
}

src_install() {
    emake DESTDIR="${D}" install prefix=/usr
    mv "${D}"/usr/lib "${D}"/usr/lib64

    # clean up
    rm -r "${D}"/usr/lib64/debug
}
