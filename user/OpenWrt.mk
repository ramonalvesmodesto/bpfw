LIBC ?= musl
ARCH ?= aarch64_cortex-a53
OPENWRT ?= ~/openwrt

TOOLCHAIN_DIR := $(lastword $(wildcard $(OPENWRT)/staging_dir/toolchain-aarch64_cortex-a53_gcc-14.3.0_musl))
TARGET_DIR    := $(lastword $(wildcard $(OPENWRT)/staging_dir/target-aarch64_cortex-a53_musl))
CC			  := $(notdir   $(wildcard $(TOOLCHAIN_DIR)/bin/aarch64-openwrt-linux-gcc))

ifndef TOOLCHAIN_DIR
$(error "'$(OPENWRT)/staging_dir/toolchain-$(ARCH)_$(SUFFIX)' not found")
endif

ifndef CC
$(error "GCC compiler '$(TOOLCHAIN_DIR)/bin/$(ARCH)*-openwrt-linux-musl*' not found")
endif

CFLAGS 	+= -I$(TARGET_DIR)/usr/include
LDFLAGS += -L$(TARGET_DIR)/usr/lib

export PATH 	   := $(PATH):$(TOOLCHAIN_DIR)/bin
export STAGING_DIR := $(TOOLCHAIN_DIR):$(TARGET_DIR)/usr
