# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
USE_RUBY="ruby25 ruby26 ruby27"

RUBY_FAKEGEM_RECIPE_TEST="rspec3"

RUBY_FAKEGEM_RECIPE_DOC="none"
RUBY_FAKEGEM_EXTRADOC="CHANGELOG.md README.md"

inherit ruby-fakegem

DESCRIPTION="Map simple html back into markdown, e.g. if you want to import existing html data in your application"
HOMEPAGE="http://github.com/xijo/reverse_markdown"

LICENSE="WTFPL"
SLOT="3"
KEYWORDS="~amd64"
IUSE=""

ruby_add_rdepend "
    dev-ruby/nokogiri
"

ruby_add_bdepend "
    dev-ruby/rake
"

# disable the creation of commands in /usr/bin
ruby_fakegem_binwrapper() {
    :
}
