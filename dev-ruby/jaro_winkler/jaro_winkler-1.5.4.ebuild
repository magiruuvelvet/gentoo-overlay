# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
USE_RUBY="ruby25 ruby26 ruby27"

RUBY_FAKEGEM_RECIPE_TEST="rspec3"

RUBY_FAKEGEM_RECIPE_DOC="none"

inherit ruby-fakegem

DESCRIPTION="jaro_winkler is an implementation of Jaro-Winkler"
HOMEPAGE="https://github.com/tonytonyjan/jaro_winkler"

LICENSE="MIT"
SLOT="3"
KEYWORDS="~amd64"
IUSE=""

ruby_add_bdepend "
    dev-ruby/rake
    dev-ruby/rake-compiler
"

# disable the creation of commands in /usr/bin
ruby_fakegem_binwrapper() {
    :
}

each_ruby_configure() {
    ${RUBY} -Cext/jaro_winkler extconf.rb || die
}

each_ruby_compile() {
    emake V=1 -Cext/jaro_winkler
}

each_ruby_install() {
    each_fakegem_install

    ruby_fakegem_newins ext/jaro_winkler/jaro_winkler_ext$(get_modname) lib/jaro_winkler/jaro_winkler_ext$(get_modname)
}
