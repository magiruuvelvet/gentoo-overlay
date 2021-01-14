# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
USE_RUBY="ruby25 ruby26 ruby27"

RUBY_FAKEGEM_RECIPE_TEST="rspec3"

RUBY_FAKEGEM_RECIPE_DOC="none"
RUBY_FAKEGEM_EXTRADOC="README.md"

inherit ruby-fakegem

DESCRIPTION="Module for defining custom exceptions with specific messages"
HOMEPAGE="https://github.com/ruby/e2mmap"

LICENSE="MIT"
SLOT="3"
KEYWORDS="~amd64"
IUSE=""

# disable the creation of commands in /usr/bin
ruby_fakegem_binwrapper() {
    :
}
