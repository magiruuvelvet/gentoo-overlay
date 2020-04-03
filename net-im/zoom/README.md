This is a ebuild version of Zoom which doesn't remove the bundled
dependencies unlike the one in the main repositories.

If Qt was built with LLVM, clang, and lld; the Zoom client can't
handle this Qt build as it assumes a GCC+ld built Qt and fails
to start. Also the main ebuild introduced a dependency on libglvnd
which is incompatible with my userland and it breaks NVIDIA Optimus.

This ebuild just extracts stuff into /opt and creates a desktop
entry and symlink in $PATH. Zoom just works fine with its bundled
dependencies and its launcher script and also works without
requiring libglvnd so I don't understand why they introduced this
dependency in the ebuild in the first place anyways.

Happy zooming from your GNU-free userland powered by LLVM :)
