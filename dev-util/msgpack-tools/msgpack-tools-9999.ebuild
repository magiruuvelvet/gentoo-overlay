EAPI=7

inherit cmake-utils

DESCRIPTION="Command-line tools for converting between MessagePack and JSON"
HOMEPAGE="https://github.com/ludocode/msgpack-tools"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

MSGPACK_TOOLS_COMMIT=26d5bb58e37a2ae27f375c1814bc03984c997103
MPACK_COMMIT=df17e83f0fa8571b9cd0d8ccf38144fa90e244d1
RAPIDJSON_COMMIT=99ba17bd66a85ec64a2f322b68c2b9c3b77a4391
B64_COMMIT=1.2.1

PATCHES="
    ${FILESDIR}/fix-missing-macros.patch
"

SRC_URI="
    https://github.com/ludocode/msgpack-tools/archive/${MSGPACK_TOOLS_COMMIT}.zip -> ${PN}-${MSGPACK_TOOLS_COMMIT}.zip
    https://github.com/ludocode/mpack/archive/${MPACK_COMMIT}.tar.gz -> mpack-${MPACK_COMMIT}.tar.gz.keep_packed
    https://github.com/miloyip/rapidjson/archive/${RAPIDJSON_COMMIT}.tar.gz -> rapidjson-${RAPIDJSON_COMMIT}.tar.gz.keep_packed
    http://downloads.sourceforge.net/project/libb64/libb64/libb64/libb64-${B64_COMMIT}.zip -> libb64-${B64_COMMIT}.zip.keep_packed
"

src_unpack() {
    default

    elog "moving files in place..."
    mv "${WORKDIR}/msgpack-tools-${MSGPACK_TOOLS_COMMIT}" "${WORKDIR}/${P}"

    local contrib_dir="${WORKDIR}/${P}/contrib"
    mkdir -p "${contrib_dir}"

    cp "${DISTDIR}/mpack-${MPACK_COMMIT}.tar.gz.keep_packed"         "${contrib_dir}/mpack-${MPACK_COMMIT}.tar.gz"
    cp "${DISTDIR}/rapidjson-${RAPIDJSON_COMMIT}.tar.gz.keep_packed" "${contrib_dir}/rapidjson-${RAPIDJSON_COMMIT}.tar.gz"
    cp "${DISTDIR}/libb64-${B64_COMMIT}.zip.keep_packed"             "${contrib_dir}/libb64-${B64_COMMIT}.zip"
}
