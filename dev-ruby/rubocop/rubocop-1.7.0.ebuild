# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
USE_RUBY="ruby25 ruby26 ruby27"

RUBY_FAKEGEM_RECIPE_TEST="rspec3"

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
	dev-ruby/unicode-display_width
	>=dev-ruby/parser-2.7
	<dev-ruby/parser-3.0
	=dev-ruby/rubocop-ast-1.4.0
"
