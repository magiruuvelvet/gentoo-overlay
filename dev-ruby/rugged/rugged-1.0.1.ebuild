EAPI=7
USE_RUBY="ruby25 ruby26 ruby27"

RUBY_FAKEGEM_RECIPE_TEST="rspec3"

RUBY_FAKEGEM_RECIPE_DOC="none"

inherit ruby-fakegem

DESCRIPTION="ruby bindings to libgit2 "
HOMEPAGE="https://github.com/libgit2/rugged"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
    ~dev-libs/libgit2-${PV}
"
BDEPEND="${DEPEND}"
RDEPEND="${DEPEND}"

# disable the creation of commands in /usr/bin
ruby_fakegem_binwrapper() {
    :
}

each_ruby_configure() {
    ${RUBY} -Cext/rugged extconf.rb --use-system-libraries || die
}

each_ruby_compile() {
    emake V=1 -Cext/rugged
}

each_ruby_install() {
    each_fakegem_install

    ruby_fakegem_newins ext/rugged/rugged$(get_modname) lib/rugged/rugged$(get_modname)
}
