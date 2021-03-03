EAPI=7

USE_RUBY="ruby25 ruby26 ruby27"

RUBY_FAKEGEM_GEMSPEC="${PN}.gemspec"
RUBY_FAKEGEM_BINWRAP=""

inherit ruby-fakegem

DESCRIPTION="Solargraph plugin to add awareness of Rails-specific code"
HOMEPAGE="https://github.com/iftheshoefritz/solargraph-rails"
SRC_COMMIT="d97c85b98c7fe18333304b2c534932a4fde9db84"
SRC_URI="${HOMEPAGE}/archive/${SRC_COMMIT}.zip -> ${PN}-${SRC_COMMIT}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RUBY_S="${PN}-${SRC_COMMIT}"

ruby_add_rdepend "
    dev-ruby/solargraph
"

# disable the creation of commands in /usr/bin
ruby_fakegem_binwrapper() {
    :
}
