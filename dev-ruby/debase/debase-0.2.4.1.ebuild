EAPI=7
USE_RUBY="ruby25 ruby26 ruby27"

RUBY_FAKEGEM_RECIPE_TEST="rspec3"

RUBY_FAKEGEM_GEMSPEC="${PN}.gemspec"

RUBY_FAKEGEM_RECIPE_DOC="none"
RUBY_FAKEGEM_EXTRADOC="README.md"

inherit ruby-fakegem

DESCRIPTION="debase is a fast implementation of the standard Ruby debugger debug.rb for Ruby 2.0."
HOMEPAGE="https://github.com/denofevil/debase"

LICENSE="BSD-2-Clause"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_bdepend "
    dev-ruby/debase-ruby_core_source
"

each_ruby_configure() {
    ${RUBY} -Cext extconf.rb --use-system-libraries || die
}

each_ruby_compile() {
    emake V=1 -Cext
}

each_ruby_install() {
    each_fakegem_install

    ruby_fakegem_newins ext/debase_internals.so lib/debase_internals.so
}
