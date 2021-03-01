EAPI=7
USE_RUBY="ruby25 ruby26 ruby27"

RUBY_FAKEGEM_RECIPE_TEST="rspec3"

RUBY_FAKEGEM_GEMSPEC="${PN}.gemspec"

RUBY_FAKEGEM_RECIPE_DOC="none"
RUBY_FAKEGEM_EXTRADOC=""

inherit ruby-fakegem

DESCRIPTION="An interface which glues ruby-debug to IDEs"
HOMEPAGE="https://github.com/ruby-debug/ruby-debug-ide"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_rdepend "
	dev-ruby/rake
"

all_ruby_install() {
    all_fakegem_install

    rm -f "${ED}/usr/bin/gdb_wrapper"
}
