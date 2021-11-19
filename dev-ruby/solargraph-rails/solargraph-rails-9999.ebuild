EAPI=7

USE_RUBY="ruby25 ruby26 ruby27"

RUBY_FAKEGEM_VERSION="0.2.2.pre.3"
RUBY_FAKEGEM_GEMSPEC="${PN}.gemspec"
RUBY_FAKEGEM_BINWRAP=""

inherit ruby-fakegem

DESCRIPTION="Solargraph plugin to add awareness of Rails-specific code"
HOMEPAGE="https://github.com/iftheshoefritz/solargraph-rails"
SRC_COMMIT="812d58d27f21e9314b3a575ed1cdccd0fdbedc1b"
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
