EAPI=7
USE_RUBY="ruby25 ruby26 ruby27"

RUBY_FAKEGEM_RECIPE_TEST="rspec3"

RUBY_FAKEGEM_GEMSPEC="${PN}.gemspec"

RUBY_FAKEGEM_RECIPE_DOC="none"
RUBY_FAKEGEM_EXTRADOC="README.md"

inherit ruby-fakegem

DESCRIPTION="Gem to provide Ruby core source files for C extensions that need them."
HOMEPAGE="https://github.com/os97673/debase-ruby_core_source"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
