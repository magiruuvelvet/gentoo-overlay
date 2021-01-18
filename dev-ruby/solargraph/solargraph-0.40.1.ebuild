# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
USE_RUBY="ruby25 ruby26 ruby27"

RUBY_FAKEGEM_RECIPE_TEST="rspec3"

RUBY_FAKEGEM_GEMSPEC="${PN}.gemspec"

RUBY_FAKEGEM_RECIPE_DOC="none"
RUBY_FAKEGEM_EXTRADOC="CHANGELOG.md README.md"

inherit ruby-fakegem

DESCRIPTION="A Ruby language server"
HOMEPAGE="https://solargraph.org/"

LICENSE="MIT"
SLOT="3"
KEYWORDS="~amd64"
IUSE=""

ruby_add_rdepend "
	>=dev-ruby/bundler-1.17.2
	>=dev-ruby/kramdown-2.3
	>=dev-ruby/kramdown-parser-gfm-1.1
	>=dev-ruby/parser-2.7
	<dev-ruby/parser-3.0
	>=dev-ruby/thor-1.0
	>=dev-ruby/yard-0.9
	>=dev-ruby/backport-1.1
	>=dev-ruby/e2mmap-0.1
	>=dev-ruby/jaro_winkler-1.5
	>=dev-ruby/reverse_markdown-2.0
	<dev-ruby/reverse_markdown-3.0
	=dev-ruby/rubocop-1.7.0
	>=dev-ruby/tilt-2.0
"

ruby_add_bdepend "
    >=dev-ruby/yard-0.9
"

each_ruby_install() {
    each_fakegem_install

    # ensure the yardoc directory exists within the gem path
    # otherwise solargraph terminates with an error that no yardoc was found
    # just slamming the README in there makes solargraph work
    ruby_fakegem_newins README.md yardoc/README.md
}
