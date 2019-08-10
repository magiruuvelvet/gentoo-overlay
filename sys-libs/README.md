# LLVM Runtime

Patched to aggressively force compiler-rt and forcefully remove GCC compatibility.
This is preferred for a pure 100% LLVM toolchain. I don't want LLVM and clang to
depend on GCC, as well as the standard libraries and applications I compile with it.

The diff files contain the applied patches for easier updating to LLVM 9.0 later.


### build system bug

compiler-rt-sanitizers has an issue building for a multilib system, where
the wrong architecture is used when building the 32-bit versions, resulting
in a linker error.
