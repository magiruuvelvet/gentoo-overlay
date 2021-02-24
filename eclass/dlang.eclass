# @ECLASS: dlang.eclass
# @DESCRIPTION:
# based on dlang overlay eclass, but removed support for everything except LDC
# and adapted to a system root installation in /usr

if [[ ${___ECLASS_ONCE_DLANG} != "recur -_+^+_- spank" ]] ; then
___ECLASS_ONCE_DLANG="recur -_+^+_- spank"

if has ${EAPI:-0} 0 1 2 3 4 5; then
	die "EAPI must be >= 6 for dlang packages."
fi

inherit flag-o-matic
test ${EAPI:-0} -lt 7 && inherit eapi7-ver

EXPORT_FUNCTIONS src_configure src_compile src_test src_install

dlang_src_configure() {
	__dlang_phase_wrapper configure
}

dlang_src_compile() {
	__dlang_phase_wrapper compile
}

dlang_src_test() {
	__dlang_phase_wrapper test
}

dlang_src_install() {
	__dlang_phase_wrapper install
}

# @FUNCTION: dlang_exec
# @DESCRIPTION:
# Run and print a shell command. Aborts the ebuild on error using "die".
dlang_exec() {
    echo "${@}"
    ${@} || die
}

# @FUNCTION: dlang_compile_bin
# @DESCRIPTION:
# Compiles a D application. The first argument is the output file name, the
# other arguments are source files. Additional variables can be set to fine tune
# the compilation. They will be prepended with the proper flags for each
# compiler:
# versions - a list of versions to activate during compilation
# imports - a list of import paths
# string_imports - a list of string import paths
#
# Additionally, if the ebuild offers the "debug" use flag, we will automatically
# raise the debug level to 1 during compilation.
dlang_compile_bin() {
    local binname="${1}"
    local sources="${@:2}"

    dlang_exec ${DC} ${DCFLAGS} ${sources} $(__dlang_additional_flags) \
        ${LDFLAGS} ${DLANG_OUTPUT_FLAG}${binname}
}

# @FUNCTION: dlang_compile_lib_a
# @DESCRIPTION:
# Compiles a D static library. The first argument is the output file name, the
# other arguments are source files. Additional variables and the
# "debug" use flag will be handled as described in dlang_compile_bin().
dlang_compile_lib_a() {
    local libname="${1}"
    local sources="${@:2}"

    dlang_exec ${DC} ${DCFLAGS} ${sources} $(__dlang_additional_flags) \
        ${LDFLAGS} ${DLANG_A_FLAGS} ${DLANG_OUTPUT_FLAG}${libname}
}

# @FUNCTION: dlang_compile_lib_so
# @DESCRIPTION:
# Compiles a D shared library. The first argument is the output file name, the
# second argument is the soname (typically file name without patch level
# suffix), the other arguments are source files. Additional variables and the
# "debug" use flag will be handled as described in dlang_compile_bin().
dlang_compile_lib_so() {
    local libname="${1}"
    local soname="${2}"
    local sources="${@:3}"

    dlang_exec ${DC} ${DCFLAGS} -m${MODEL} ${sources} $(__dlang_additional_flags) \
        ${LDFLAGS} ${DLANG_SO_FLAGS} ${DLANG_LINKER_FLAG}-soname=${soname} \
        ${DLANG_OUTPUT_FLAG}${libname}
}

# @FUNCTION: dlang_convert_ldflags
# @DESCRIPTION:
# Makes linker flags meant for clang understandable for the current D compiler.
# Basically it replaces -L with what the D compiler uses as linker prefix.
dlang_convert_ldflags() {
    local set prefix flags=()
    if [[ is_dmd ]]; then
        prefix="-L"
    elif [[ is_ldc ]]; then
        prefix="-L="
    fi
    for set in ${LDFLAGS}; do
        if [[ "${set:0:4}" == "-Wl," ]]; then
            set=${set/-Wl,/${prefix}}
            flags+=(${set//,/ ${prefix}})
        elif [[ "${set:0:9}" == "-Xlinker " ]]; then
            flags+=(${set/-Xlinker /${prefix}})
        elif [[ "${set:0:2}" == "-L" ]]; then
            flags+=(${set/-L/${prefix}})
        else
            flags+=(${set})
        fi
    done
    echo "${flags[@]}"
}

# @FUNCTION: dlang_system_imports
# @DESCRIPTION:
# Returns a list of standard system import paths (one per line) for the current
# D compiler. This includes druntime and Phobos as well as compiler specific
# paths.
dlang_system_imports() {
    echo "/usr/include/d"
    echo "/usr/include/d/ldc"
}

dlang_single_config() {
    debug-print-function ${FUNCNAME} "${@}"

    __dlang_use_build_vars "${@}"
}

### Non-public helper functions ###

__dlang_phase_wrapper() {
    dlang_phase() {
        if declare -f d_src_${1} >/dev/null ; then
            d_src_${1}
        else
            default_src_${1}
        fi
    }

    dlang_single_config dlang_phase "${1}"
}

__dlang_use_build_vars() {
    # Now we define some variables and then call the function.
    # LIBDIR_${ABI} is used by the dolib.* functions, that's why we override it per compiler.
    # The original value is exported as LIBDIR_HOST.

    local libdir_var="LIBDIR_${ABI}"
    export LIBDIR_HOST="${!libdir_var}"
    export ABI="$(echo ${MULTIBUILD_VARIANT} | cut -d- -f1)"

    export DLANG_VENDOR="LDC"

    case "${ABI}" in
        "default") ;;
        "x86"*)    export MODEL= ;;
        *)         export MODEL=64 ;;
    esac

    export LIBDIR_${ABI}="../usr/lib${MODEL}"
    export DMD="/usr/bin/ldmd2"
    export DC="/usr/bin/ldc2"
    # To allow separate compilation and avoid object file name collisions,
    # we append -op (do not strip paths from source file).
    export DCFLAGS="${LDCFLAGS} -op"
    export DLANG_LINKER_FLAG="-L="
    export DLANG_A_FLAGS="-lib -relocation-model=pic"
    export DLANG_SO_FLAGS="-shared -relocation-model=pic"
    export DLANG_OUTPUT_FLAG="-of="
    export DLANG_VERSION_FLAG="-d-version"
    export DLANG_UNITTEST_FLAG="-unittest"

    export LDFLAGS=`dlang_convert_ldflags`
    "${@}"
}

__dlang_prefix_words() {
    for arg in ${*:2}; do
        echo -n " $1$arg"
    done
}

__dlang_additional_flags() {
    local import_prefix="-I="
    local string_import_prefix="-J="
    local debug_flags="-d-debug"

    echo $(has debug ${IUSE} && use debug && echo ${debug_flags})\
        $(__dlang_prefix_words "${DLANG_VERSION_FLAG}=" $versions)\
        $(__dlang_prefix_words $import_prefix $imports)\
        $(__dlang_prefix_words $string_import_prefix $string_imports)\
        $(__dlang_prefix_words "${DLANG_LINKER_FLAG}-l" $libs)
}

fi
