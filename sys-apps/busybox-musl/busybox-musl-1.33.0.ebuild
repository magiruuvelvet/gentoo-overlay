# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic toolchain-funcs

DESCRIPTION="Utilities for rescue and embedded systems"
HOMEPAGE="https://www.busybox.net/"
MY_P=busybox-${PV/_/-}
SRC_URI="https://www.busybox.net/downloads/${MY_P}.tar.bz2"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86 ~amd64-linux ~x86-linux"

LICENSE="GPL-2" # GPL-2 only
SLOT="0"
IUSE="debug ipv6 math systemd +static"
RESTRICT="test"

S="${WORKDIR}/${MY_P}"

DEPEND="
    sys-libs/musl
"

BDEPEND="
    sys-kernel/linux-headers
"

export CC="${FILESDIR}/musl-clang"
export HOSTCC="${FILESDIR}/musl-clang"
export HOSTCFLAGS="-v -D_POSIX_SOURCE"

busybox_config_option() {
	local flag=$1 ; shift
	if [[ ${flag} != [yn] && ${flag} != \"* ]] ; then
		busybox_config_option $(usex ${flag} y n) "$@"
		return
	fi
	local expr
	while [[ $# -gt 0 ]] ; do
		case ${flag} in
		y) expr="s:.*\<CONFIG_$1\>.*set:CONFIG_$1=y:g" ;;
		n) expr="s:CONFIG_$1=y:# CONFIG_$1 is not set:g" ;;
		*) expr="s:.*\<CONFIG_$1\>.*:CONFIG_$1=${flag}:g" ;;
		esac
		sed -i -e "${expr}" .config || die
		einfo "$(grep "CONFIG_$1[= ]" .config || echo "Could not find CONFIG_$1 ...")"
		shift
	done
}

busybox_config_enabled() {
	local val=$(sed -n "/^CONFIG_$1=/s:^[^=]*=::p" .config)
	case ${val} in
	"") return 1 ;;
	y)  return 0 ;;
	*)  echo "${val}" | sed -r 's:^"(.*)"$:\1:' ;;
	esac
}

# patches go here!
PATCHES=(
	"${FILESDIR}"/busybox-1.26.2-bb.patch
	"${FILESDIR}"/busybox-include-alloca.patch
	"${FILESDIR}"/busybox-force-musl-libc-mode.patch
)

src_prepare() {
	default
	unset KBUILD_OUTPUT #88088
	append-flags -fno-strict-aliasing #310413
	use ppc64 && append-flags -mminimal-toc #130943

	# flag cleanup
	sed -i -r \
		-e 's:[[:space:]]?-(Werror|Os|falign-(functions|jumps|loops|labels)=1|fomit-frame-pointer)\>::g' \
		Makefile.flags || die
	sed -i '/^#error Aborting compilation./d' applets/applets.c || die
	sed -i \
		-e "/^CROSS_COMPILE/s:=.*:= ${CHOST}-:" \
		-e "/^AR\>/s:=.*:= $(tc-getAR):" \
		-e "/^CC\>/s:=.*:= ${CC}:" \
		-e "/^HOSTCC/s:=.*:= ${HOSTCC}:" \
		-e "/^HOSTCFLAGS/s:=.*:= $HOSTCFLAGS:" \
		-e "/^PKG_CONFIG\>/s:=.*:= $(tc-getPKG_CONFIG):" \
		Makefile || die
	sed -i \
		-e 's:-static-libgcc::' \
		Makefile.flags || die
}

src_configure() {

	# setup the config file
	emake -j1 -s allyesconfig >/dev/null
	# nommu forces a bunch of things off which we want on #387555
	busybox_config_option n NOMMU
	sed -i '/^#/d' .config
	yes "" | emake -j1 -s oldconfig >/dev/null

	# now turn off stuff we really don't want
	busybox_config_option n DMALLOC
	busybox_config_option n FEATURE_2_4_MODULES #607548
	busybox_config_option n FEATURE_SUID_CONFIG
	busybox_config_option n BUILD_AT_ONCE
	busybox_config_option n BUILD_LIBBUSYBOX
	busybox_config_option n FEATURE_CLEAN_UP
	busybox_config_option n MONOTONIC_SYSCALL
	busybox_config_option n USE_PORTABLE_CODE
	busybox_config_option n WERROR
	# triming the BSS size may be dangerous
	busybox_config_option n FEATURE_USE_BSS_TAIL

	# These cause trouble with musl.
	busybox_config_option n FEATURE_UTMP
	busybox_config_option n EXTRA_COMPAT
	busybox_config_option n FEATURE_VI_REGEX_SEARCH

	# If these are not set and we are using a uclibc/busybox setup
	# all calls to system() will fail.
	busybox_config_option y ASH
	busybox_config_option y SH_IS_ASH
	busybox_config_option n HUSH
	busybox_config_option n SH_IS_HUSH

	busybox_config_option '"/run"' PID_FILE_PATH
	busybox_config_option '"/run/ifstate"' IFUPDOWN_IFSTATE_PATH

	# disable ipv6 applets
	if ! use ipv6; then
		busybox_config_option n FEATURE_IPV6
		busybox_config_option n TRACEROUTE6
		busybox_config_option n PING6
		busybox_config_option n UDHCPC6
	fi

	busybox_config_option n PAM
	busybox_config_option static STATIC
	busybox_config_option n {K,SYS}LOGD LOGGER
	busybox_config_option systemd FEATURE_SYSTEMD
	busybox_config_option math FEATURE_AWK_LIBM
	busybox_config_option n MDEV

	# all the debug options are compiler related, so punt them
	busybox_config_option n DEBUG_SANITIZE
	busybox_config_option n DEBUG
	busybox_config_option y NO_DEBUG_LIB
	busybox_config_option n DMALLOC
	busybox_config_option n EFENCE
	busybox_config_option $(usex debug y n) TFTP_DEBUG

	busybox_config_option n SELINUX

	# this opt only controls mounting with <linux-2.6.23
	busybox_config_option n FEATURE_MOUNT_NFS

	# glibc-2.26 and later does not ship RPC implientation
	busybox_config_option n FEATURE_HAVE_RPC
	busybox_config_option n FEATURE_INETD_RPC

	# default a bunch of uncommon options to off
	local opt
	for opt in \
		ADD_SHELL \
		BEEP BOOTCHARTD \
		CRONTAB \
		DC DEVFSD DNSD DPKG{,_DEB} \
		FAKEIDENTD FBSPLASH FOLD FSCK_MINIX FTP{GET,PUT} \
		FEATURE_DEVFS \
		HOSTID HUSH \
		INETD INOTIFYD IPCALC \
		LOCALE_SUPPORT LOGNAME LPD \
		MAKEMIME MKFS_MINIX MSH \
		OD \
		RDEV READPROFILE REFORMIME REMOVE_SHELL RFKILL RUN_PARTS RUNSV{,DIR} \
		SLATTACH SMEMCAP SULOGIN SV{,LOGD} \
		TASKSET TCPSVD \
		RPM RPM2CPIO \
		UDPSVD UUDECODE UUENCODE
	do
		busybox_config_option n ${opt}
	done

	emake -j1 oldconfig > /dev/null
}

src_compile() {
	unset KBUILD_OUTPUT #88088
	export SKIP_STRIP=y

	emake V=1 CFLAGS="${CFLAGS}" busybox
}

src_install() {
	unset KBUILD_OUTPUT #88088

	into /usr/musl
	dodir /bin
	newbin busybox_unstripped busybox
}
