#
# APPLE SILICON
#

# If you're on Apple Silicon macOS 13.x.x, or 12.x.x
# Requires Filesystem Protections, Debugging Restrictions and NVRAM Protection to be disabled
# (printed warning can be safely ignored)
csrutil disable --with kext --with dtrace --with basesystem
