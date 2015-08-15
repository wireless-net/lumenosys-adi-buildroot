################################################################################
#
# erlang_nommu
#
################################################################################

ERLANG_NOMMU_VERSION = 17.0
ERLANG_NOMMU_SITE = http://www.erlang.org/download
ERLANG_NOMMU_SOURCE = otp_src_$(ERLANG_NOMMU_VERSION).tar.gz
ERLANG_NOMMU_DEPENDENCIES = host-erlang_nommu
ERLANG_NOMMU_INSTALL_STAGING = YES
ERLANG_NOMMU_INSTALL_TARGET = NO
HOST_ERLANG_NOMMU_DEPENDENCIES =

ERLANG_NOMMU_LICENSE = EPL
ERLANG_NOMMU_LICENSE_FILES = EPLICENCE

# The configure checks for these functions fail incorrectly
ERLANG_NOMMU_CONF_ENV = ac_cv_func_isnan=yes ac_cv_func_isinf=yes
#ERLANG_NOMMU_CONF_ENV += CFLAGS=" -O2 -DSMALL_MEMORY"

# add cross system root
ERLANG_NOMMU_CONF_ENV += erl_xcomp_sysroot="$(STAGING_DIR)"  

ifeq ($(BR2_PACKAGE_ERLANG_BF53X_OPTIMIZATIONS),y)
ERLANG_NOMMU_CONF_ENV += CFLAGS=" -O2 -mcpu=bf537-0.3 -fomit-frame-pointer -funroll-loops -ffast-math -D__uClinux__"
# also could use CFLAGS -fdata-sections -ffunction-sections (but
# didn't seem to have much effect)
# ERLANG_NOMMU_CONF_ENV += LDFLAGS=" -Wl,--gc-sections"
else
ERLANG_NOMMU_CONF_ENV += CFLAGS=" -O2 -D__uClinux__"
endif

HOST_ERLANG_NOMMU_CONF_OPT = --without-javac

ERLANG_NOMMU_CONF_OPT = --without-javac
ERLANG_NOMMU_CONF_OPT += --disable-hipe
ERLANG_NOMMU_CONF_OPT += --disable-threads

ifeq ($(BR2_PACKAGE_ERLANG_DIRTY_SCHEDULERS),y)
ERLANG_NOMMU_CONF_OPT += --enable-dirty-schedulers
endif

ifeq ($(BR2_PREFER_STATIC_LIB),y)
ERLANG_NOMMU_CONF_OPT += --enable-static --disable-shared
else
ERLANG_NOMMU_CONF_OPT += --disable-static --enable-shared
endif

# try with it first
# ERLANG_NOMMU_CONF_OPT += --disable-smp
ifeq ($(BR2_PACKAGE_NCURSES),y)
ERLANG_NOMMU_CONF_OPT += --with-termcap
ERLANG_NOMMU_DEPENDENCIES += ncurses
else
ERLANG_NOMMU_CONF_OPT += --without-termcap
endif
ifeq ($(BR2_PACKAGE_OPENSSL),y)
ERLANG_NOMMU_CONF_OPT += --with-ssl=$(STAGING_DIR)/usr/lib
ERLANG_NOMMU_DEPENDENCIES += openssl
else
ERLANG_NOMMU_CONF_OPT += --without-ssl
endif
ifeq ($(BR2_PACKAGE_ZLIB),y)
ERLANG_NOMMU_CONF_OPT += --enable-shared-zlib
ERLANG_NOMMU_DEPENDENCIES += zlib
endif

# Remove source, example, gs and wx files from the target
# TODO: make sure this really does remove the sources!
ERLANG_NOMMU_REMOVE_PACKAGES =  appmon
ERLANG_NOMMU_REMOVE_PACKAGES += diameter
ERLANG_NOMMU_REMOVE_PACKAGES += megaco
ERLANG_NOMMU_REMOVE_PACKAGES += snmp
ERLANG_NOMMU_REMOVE_PACKAGES += asn1
ERLANG_NOMMU_REMOVE_PACKAGES += edoc
ERLANG_NOMMU_REMOVE_PACKAGES += mnesia
ERLANG_NOMMU_REMOVE_PACKAGES += common_test
ERLANG_NOMMU_REMOVE_PACKAGES += eldap
#ERLANG_NOMMU_REMOVE_PACKAGES += observer
ERLANG_NOMMU_REMOVE_PACKAGES += syntax_tools
ERLANG_NOMMU_REMOVE_PACKAGES += compiler
ERLANG_NOMMU_REMOVE_PACKAGES += erl_docgen
ERLANG_NOMMU_REMOVE_PACKAGES += orber
ERLANG_NOMMU_REMOVE_PACKAGES += test_server
ERLANG_NOMMU_REMOVE_PACKAGES += cosEvent
ERLANG_NOMMU_REMOVE_PACKAGES += os_mon          
ERLANG_NOMMU_REMOVE_PACKAGES += toolbar
ERLANG_NOMMU_REMOVE_PACKAGES += cosEventDomain
ERLANG_NOMMU_REMOVE_PACKAGES += otp_mibs
ERLANG_NOMMU_REMOVE_PACKAGES += tools
ERLANG_NOMMU_REMOVE_PACKAGES += cosFileTransfer
ERLANG_NOMMU_REMOVE_PACKAGES += et
ERLANG_NOMMU_REMOVE_PACKAGES += parsetools
ERLANG_NOMMU_REMOVE_PACKAGES += tv
ERLANG_NOMMU_REMOVE_PACKAGES += cosNotification
ERLANG_NOMMU_REMOVE_PACKAGES += eunit
ERLANG_NOMMU_REMOVE_PACKAGES += percept
ERLANG_NOMMU_REMOVE_PACKAGES += typer
ERLANG_NOMMU_REMOVE_PACKAGES += cosProperty
ERLANG_NOMMU_REMOVE_PACKAGES += gs
ERLANG_NOMMU_REMOVE_PACKAGES += pman
ERLANG_NOMMU_REMOVE_PACKAGES += webtool
ERLANG_NOMMU_REMOVE_PACKAGES += cosTime
ERLANG_NOMMU_REMOVE_PACKAGES += hipe
ERLANG_NOMMU_REMOVE_PACKAGES += public_key
ERLANG_NOMMU_REMOVE_PACKAGES += wx
ERLANG_NOMMU_REMOVE_PACKAGES += cosTransactions
ERLANG_NOMMU_REMOVE_PACKAGES += ic
ERLANG_NOMMU_REMOVE_PACKAGES += reltool
ERLANG_NOMMU_REMOVE_PACKAGES += xmerl
#ERLANG_NOMMU_REMOVE_PACKAGES += debugger
ERLANG_NOMMU_REMOVE_PACKAGES += inets
#ERLANG_NOMMU_REMOVE_PACKAGES += runtime_tools
ERLANG_NOMMU_REMOVE_PACKAGES += dialyzer

define ERLANG_NOMMU_REMOVE_UNUSED
	find $(TARGET_DIR)/usr/lib/erlang -type d -name src -prune -exec rm -rf {} \;
	find $(TARGET_DIR)/usr/lib/erlang -type d -name include -prune -exec rm -rf {} \;
	find $(TARGET_DIR)/usr/lib/erlang -type d -name examples -prune -exec rm -rf {} \;
	for package in $(ERLANG_NOMMU_REMOVE_PACKAGES); do \
		rm -rf $(TARGET_DIR)/usr/lib/erlang/lib/$${package}-*; \
	done
endef

ERLANG_NOMMU_POST_INSTALL_TARGET_HOOKS += ERLANG_NOMMU_REMOVE_UNUSED

$(eval $(autotools-package))
$(eval $(host-autotools-package))
