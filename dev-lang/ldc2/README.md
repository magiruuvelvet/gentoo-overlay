You need to bootstrap ldc2 youself and temporarily patch the ebuild
to export the PATH to the ldmd2 location and remove BDEPEND.

This version of ldc2 is not slotted and lives in the system root
under /usr and the config under /etc.
