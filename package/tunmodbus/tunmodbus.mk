########################################################################
# tunmodbus
########################################################################

TUNMODBUS_VERSION = 0.1
TUNMODBUS_SITE_METHOD = file
TUNMODBUS_SOURCE = tunmodbus-$(TUNMODBUS_VERSION).tar.gz
TUNMODBUS_SITE = /home/dbutter/projects/lumenosys/bsp/obsidian/
TUNMODBUS_INSTALL_STAGING = NO
TUNMODBUS_INSTALL_TARGET = YES
TUNMODBUS_DEPENDENCIES = libmodbus host-pkgconf
TUNMODBUS_CONF_OPT = "-DLIBMODBUS_INSTALL_PREFIX=$(STAGING_DIR)"

$(eval $(cmake-package))
