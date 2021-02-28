EAPI=7

inherit xdg-utils

DESCRIPTION="SmoothVideo Project 4 (SVP4)"
HOMEPAGE="https://www.svp-team.com/wiki/SVP:Linux"
SRC_URI="https://storage.magiruuvelvet.gdn/ebuild/svp4-linux.${PV}.tar.bz2 -> ${PN}-${PV}.tbz2"

LICENSE="CUSTOM"
SLOT="0"
KEYWORDS="amd64"

# runtime dependencies
DEPEND="
    dev-qt/qtcore
    dev-qt/qtgui
    dev-qt/qtwidgets
    dev-qt/qtsvg
    dev-qt/qtscript
    dev-qt/qtdeclarative
    dev-python/PyQt5
    media-libs/vapoursynth
    dev-libs/libusb
    sys-process/lsof
"
RDEPEND="${DEPEND}"

# build dependencies
BDEPEND="
    app-arch/bzip2
    app-arch/p7zip
"

src_unpack() {
    # run the default unpack
    unpack "${P}.tbz2"

    # name of the installer file
    local installer="svp4-linux-64.run"

    # temporary directory where extracted 7z chunks go
    mkdir -p "${S}/installer"

    # find and extract 7z chunks from installer
    LANG=C grep --only-matching --byte-offset --binary --text $'7z\xBC\xAF\x27\x1C' "$installer" |
        cut -f1 -d: |
        while read ofs; do dd if="$installer" bs=1M iflag=skip_bytes status=none skip=$ofs of="${S}/installer/bin-$ofs.7z"; done

    # extract the 7z chunks to get the final application
    for f in "${S}/installer/"*.7z; do
        7z -bd -bb0 -y x -o"${S}/extracted/" "$f" || true
    done
}

src_prepare() {
    cd "${S}/extracted"

    # clean up
    # TODO: could be use flagged instead

    rm INSTALL
    rm add-menuitem.sh
    rm remove-menuitem.sh

    rm extensions/libsvpcode.so
    rm -r extensions/code

    rm extensions/libsvptube.so
    rm -r extensions/tube

    rm extensions/libsvpcast.so
    rm -r extensions/cast

    rm extensions/libQtZeroConf.so

    # remove bundled python qt - requires specific python version and may not work
    # prefer dev-python/PyQt5 instead
    rm extensions/libPythonQt.so

    # fix permissions (the installer normally does this)
    chmod -R +rX "${S}/extracted"

    default
}

src_configure() {
    :
}

src_install() {

    # copy extracted application
    local install_path="${ED}/opt/svp"
    mkdir -p "$install_path"
    cp -rp "${S}/extracted/." "$install_path/"
    chmod +x "$install_path"

    # create symlink for launcher
    mkdir -p "${ED}/usr/bin"
    ln -s "/opt/svp/SVPManager" "${ED}/usr/bin/svp"

    # install icons
    local icon_path="${ED}/usr/share/icons/hicolor"
    mkdir -p "$icon_path/"{32x32,48x48,64x64,128x128}"/apps"

    for size in 32 48 64 128; do
        mv "$install_path/svp-manager4-$size.png" "$icon_path/${size}x${size}/apps/svp.png"
    done

# generate desktop entry
mkdir -p "${ED}/usr/share/applications"
cat << EOF > "${ED}/usr/share/applications/svp.desktop"
[Desktop Entry]
Version=1.0
Encoding=UTF-8
Name=SVP 4 Linux
GenericName=Real time frame interpolation
Type=Application
Categories=Multimedia;AudioVideo;Player;Video;
Terminal=false
StartupNotify=true
Exec=svp %f
Icon=svp
EOF
}

pkg_postinst() {
    xdg_desktop_database_update
}

pkg_postrm() {
    xdg_desktop_database_update
}
