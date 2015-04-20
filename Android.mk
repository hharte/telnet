LOCAL_PATH := $(call my-dir)
# prebuilt libncurses
include $(CLEAR_VARS)

LOCAL_MODULE := ncurses
LOCAL_SRC_FILES := ../../android-libncurses/libs/$(TARGET_ARCH_ABI)/libncurses.so
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/../include/

include $(PREBUILT_SHARED_LIBRARY)

###################### libtelnet ######################
include $(CLEAR_VARS)

LOCAL_MODULE_TAGS := optional

LOCAL_SRC_FILES := \
	libtelnet/auth.c     libtelnet/encrypt.c  libtelnet/genget.c  libtelnet/kerberos5.c  libtelnet/spx.c \
	libtelnet/enc_des.c  libtelnet/forward.c  libtelnet/getent.c  libtelnet/misc.c       libtelnet/sra.c

LOCAL_CFLAGS := -DHAVE_CONFIG_H -DSYSCONFDIR=\"/data/data/com.magicandroidapps.betterterm/etc\" -U_XOPEN_SOURCE -D_XOPEN_SOURCE=500 -U_POSIX_C_SOURCE -D_POSIX_C_SOURCE=199506L -DNDEBUG

LOCAL_C_INCLUDES := $(LOCAL_PATH)/libtelnet

LOCAL_MODULE := libtelnetlib

include $(BUILD_STATIC_LIBRARY)

###################### telnet ######################
include $(CLEAR_VARS)
L_DEFS := -DUSE_TERMIO # -DTN3270
L_CFLAGS := $(L_DEFS)

LOCAL_SRC_FILES := \
	authenc.c main.c network.c ring.c telnet.c \
        terminal.c tn3270.c \
	utilities.c \
	commands.c \
	sys_bsd.c

LOCAL_MODULE := telnet
LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLES)
LOCAL_MODULE_TAGS := optional
LOCAL_CFLAGS := $(L_CFLAGS) -DINFTIM=-1 -DVSTATUS=18
LOCAL_C_INCLUDES := $(LOCAL_PATH)

LOCAL_SHARED_LIBRARIES += libc libtelnetlib libncurses #libssl_static libcrypto_static

#LOCAL_FORCE_STATIC_EXECUTABLE := true
include $(BUILD_EXECUTABLE)
