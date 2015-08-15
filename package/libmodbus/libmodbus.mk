################################################################################
#
# libmodbus
#
################################################################################

LIBMODBUS_VERSION = 3.1.1
LIBMODBUS_SITE = http://libmodbus.org/releases
LIBMODBUS_INSTALL_STAGING = YES

$(eval $(autotools-package))
