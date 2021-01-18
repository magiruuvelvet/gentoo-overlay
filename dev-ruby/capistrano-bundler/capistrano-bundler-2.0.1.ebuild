# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
USE_RUBY="ruby25 ruby26 ruby27"

RUBY_FAKEGEM_RECIPE_TEST="rspec3"

RUBY_FAKEGEM_GEMSPEC="${PN}.gemspec"

RUBY_FAKEGEM_RECIPE_DOC="none"
RUBY_FAKEGEM_EXTRADOC="CHANGELOG.md README.md"

inherit ruby-fakegem

DESCRIPTION="A distributed application deployment system (bundler support)"
HOMEPAGE="https://capistranorb.com/"

LICENSE="MIT"
SLOT="3"
KEYWORDS="~amd64"
IUSE=""

ruby_add_rdepend "
	dev-ruby/capistrano
	dev-ruby/bundler
"
