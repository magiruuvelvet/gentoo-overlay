# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
USE_RUBY="ruby25 ruby26 ruby27"

RUBY_FAKEGEM_RECIPE_TEST="rspec3"

# binaries are not installing for some reason, but to make sure the below workaround
# doesn't break on a ruby-fakegem update, ensure no wrappers are installed
# also the official wrapper requires benchmark, which isn't required for anything else
# so my wrapper is more "lightweight"
RUBY_FAKEGEM_BINWRAP=""

RUBY_FAKEGEM_RECIPE_DOC="none"
RUBY_FAKEGEM_EXTRADOC="README.md"

inherit ruby-fakegem

DESCRIPTION="RuboCop is a Ruby code style checking and code formatting tool. It aims to enforce the community-driven Ruby Style Guide"
HOMEPAGE="https://rubocop.org/"

LICENSE="MIT"
SLOT="3"
KEYWORDS="~amd64"
IUSE=""

ruby_add_rdepend "
	dev-ruby/parallel
	dev-ruby/rainbow
	dev-ruby/rexml
	dev-ruby/regexp_parser
	dev-ruby/ruby-progressbar
	>=dev-ruby/unicode-display_width-1.7.0
	<dev-ruby/unicode-display_width-2.0
	>=dev-ruby/parser-2.7
	<dev-ruby/parser-3.0
	=dev-ruby/rubocop-ast-1.4.0
"

each_ruby_install() {
    each_fakegem_install

    ruby_fakegem_newins config/default.yml config/default.yml
    ruby_fakegem_newins config/obsoletion.yml config/obsoletion.yml

    ruby_fakegem_newins "${FILESDIR}/rubocop" exe/rubocop
}

all_ruby_install() {
    all_fakegem_install

    # WORKAROUND:
    # install missing rubocop command line interface
    # for some reason the Portage gem handler isn't picking it up
    # it works when doing "gem install rubocop"
    exeinto /usr/bin
    doexe "${FILESDIR}/rubocop"
}
