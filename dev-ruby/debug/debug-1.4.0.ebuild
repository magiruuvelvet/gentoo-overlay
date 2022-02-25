EAPI=7
USE_RUBY="ruby27"

RUBY_FAKEGEM_RECIPE_TEST="rspec3"

RUBY_FAKEGEM_RECIPE_DOC="none"

inherit ruby-fakegem

DESCRIPTION="Debugging functionality for Ruby"
HOMEPAGE="https://github.com/ruby/debug"

LICENSE="BSD-2-Clause"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_bdepend "
    dev-ruby/rake
"

# disable the creation of commands in /usr/bin
ruby_fakegem_binwrapper() {
    :
}

each_ruby_configure() {
    ${RUBY} -Cext/debug extconf.rb || die
}

each_ruby_compile() {
    emake V=1 -Cext/debug
}

each_ruby_install() {
    each_fakegem_install

    ruby_fakegem_newins ext/debug/debug$(get_modname) lib/debug/debug$(get_modname)
    ruby_fakegem_newins exe/rdbg bin/rdbg
}

all_ruby_install() {
    all_fakegem_install

    #exeinto /usr/bin
    #doexe "${WORKDIR}/all/${P}/exe/rdbg"
}
