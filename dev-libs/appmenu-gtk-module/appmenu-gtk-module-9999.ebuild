EAPI=7

inherit git-r3 cmake-utils

DESCRIPTION="Gtk module for exporting menus"
LICENSE="LGPL3"
EGIT_REPO_URI="https://gitlab.com/vala-panel-project/vala-panel-appmenu"

SLOT="0"
KEYWORDS="~amd64"
IUSE="gtk3 gtk2"

S="${WORKDIR}/${P}/subprojects/appmenu-gtk-module"

DEPEND="
    x11-libs/gtk+
"

PATCHES="
    ${FILESDIR}/enable-gnu-source.patch
    ${FILESDIR}/fixes.patch
"

src_configure() {
    local mycmakeargs=(
        -DCMAKE_INSTALL_PREFIX=/usr
        -DCMAKE_INSTALL_LIBDIR=lib64
        -DCMAKE_INSTALL_LIBEXECDIR=lib
        -DGSETTINGS_LOCALINSTALL=OFF
    )

    cmake-utils_src_configure
}

# copied from gnome2 inherit because it throws an error when using EAPI version 7
_glib_update_schemas() {
    local updater="/usr/bin/glib-compile-schemas"

    ebegin "Updating GSettings schemas"
    ${updater} --allow-any-name "$@" "/usr/share/glib-2.0/schemas" &>/dev/null
    eend $?
}

pkg_postinst() {
    _glib_update_schemas
}

pkg_postrm() {
    _glib_update_schemas
}
