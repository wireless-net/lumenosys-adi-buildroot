#################################################################
#
# libpaho_embed_mqtt
#
#################################################################

LIBPAHO_EMBED_MQTT_VERSION = 05def0e77fe47168fc5797d99229bb8839450a03
LIBPAHO_EMBED_MQTT_SITE = git://git.eclipse.org/gitroot/paho/org.eclipse.paho.mqtt.embedded-c.git
LIBPAHO_EMBED_MQTT_SITE_METHOD = git
LIBPAHO_EMBED_MQTT_INSTALL_STAGING = YES

define LIBPAHO_EMBED_MQTT_BUILD_CMDS
	$(MAKE) CC=$(TARGET_CC) LD=$(TARGET_LD) -C $(@D) lib
endef

define LIBPAHO_EMBED_MQTT_INSTALL_STAGING_CMDS
	$(INSTALL) -D -m 0644 $(@D)/MQTTPacket/src/*.h $(STAGING_DIR)/usr/include/
	$(INSTALL) -D $(@D)/build/output/libpaho-embed-mqtt3c.so.1 $(STAGING_DIR)/usr/lib
	cd $(STAGING_DIR)/usr/lib && ln -sf libpaho-embed-mqtt3c.so.1 libpaho-embed-mqtt3c.so
endef

define LIBPAHO_EMBED_MQTT_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/build/output/libpaho-embed-mqtt3c.so.1 $(TARGET_DIR)/usr/lib
	cd $(TARGET_DIR)/usr/lib && ln -sf libpaho-embed-mqtt3c.so.1 libpaho-embed-mqtt3c.so
endef

$(eval $(generic-package))
