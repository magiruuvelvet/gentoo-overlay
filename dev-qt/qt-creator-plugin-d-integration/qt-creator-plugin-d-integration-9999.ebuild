EAPI=7

inherit qmake-utils git-r3

HOMEPAGE="https://github.com/GoldMax/QtCreatorD"
DESCRIPTION="Qt Creator plugin for D language support"
LICENSE=""
SLOT="0"

KEYWORDS="amd64"

EGIT_REPO_URI="${HOMEPAGE}"

DEPEND="
    dev-qt/qt-creator
"

BDEPEND="
    dev-qt/qt-creator-src
"

QTCREATOR_PLUGIN_PROJECTS="deditor" # dprojectmanager doesn't compile

PATCHES="
    ${FILESDIR}/qtcreator-5.14.patch
"

src_prepare() {
    # remove other qt plugins bundled in the repository
    rm -r src/plugins/{buildallbutton,debugger,projectexplorer}

    # prepend mixin to qmake projects
    for project in $QTCREATOR_PLUGIN_PROJECTS; do
        pushd src/plugins/$project
        cat "${FILESDIR}/mixin.pri" "${project}.pro" > "${project}.pro.tmp"
        mv "${project}.pro.tmp" "${project}.pro"
        if [[ "$project" == "deditor" ]]; then
            sed -i 's/json_in/DEditor\.json\.in/g' "${project}.pro"
            sed -i 's/json_out/DEditor\.json/g' "${project}.pro"
            sed -i 's/target_name/libDEditor\.so/g' "${project}.pro"
        elif [[ "$project" == "dprojectmanager" ]]; then
            sed -i 's/json_in/DProjectManager\.json\.in/g' "${project}.pro"
            sed -i 's/json_out/DProjectManager\.json/g' "${project}.pro"
            sed -i 's/target_name/libDProjectManager\.so/g' "${project}.pro"
        fi
        popd
    done

    eapply_user
    default
}

src_configure() {
    for project in $QTCREATOR_PLUGIN_PROJECTS; do
        pushd src/plugins/$project
        eqmake5
        sed -i 's/\/usr\/lib\/qtcreator/\/usr\/lib64\/qtcreator/g' Makefile
        popd
    done
}

src_compile() {
    for project in $QTCREATOR_PLUGIN_PROJECTS; do
        pushd src/plugins/$project
        emake
        popd
    done
}

src_install() {
    local distdir="${D}/usr/lib64/qtcreator/plugins"
    mkdir -p "$distdir"
    mv src/plugins/deditor/libDEditor.so "$distdir/"
}
