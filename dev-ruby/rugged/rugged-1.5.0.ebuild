EAPI=7
USE_RUBY="ruby25 ruby26 ruby27"

RUBY_FAKEGEM_RECIPE_TEST="rspec3"

RUBY_FAKEGEM_RECIPE_DOC="none"

inherit ruby-fakegem

DESCRIPTION="ruby bindings to libgit2 "
HOMEPAGE="https://github.com/libgit2/rugged"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

# no longer depend on system libgit2, fix extconf instead and use the bundled version
PATCHES="
    ${FILESDIR}/explicitly-set-cmake-generator-to-makefile.patch
"

# disable the creation of commands in /usr/bin
ruby_fakegem_binwrapper() {
    :
}

each_ruby_configure() {
    ${RUBY} -Cext/rugged extconf.rb || die
}

each_ruby_compile() {
    emake V=1 -Cext/rugged
}

each_ruby_install() {
    each_fakegem_install

    ruby_fakegem_newins ext/rugged/rugged$(get_modname) lib/rugged/rugged$(get_modname)
}
