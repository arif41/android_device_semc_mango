$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)
$(call inherit-product, device/common/gps/gps_eu_supl.mk)

# proprietary side of the device
$(call inherit-product-if-exists, vendor/semc/mango/mango-vendor.mk)


# Discard inherited values and use our own instead.
PRODUCT_NAME := mango
PRODUCT_DEVICE := mango
PRODUCT_MODEL := mango

ifeq ($(TARGET_PREBUILT_KERNEL),)
LOCAL_KERNEL := device/semc/mango/kernel
else
LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

-include device/semc/msm7x30-common/msm7x30.mk

PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel

DISABLE_DEXPREOPT := false

# These is the hardware-specific overlay, which points to the location
# of hardware-specific resource overrides, typically the frameworks and
# application settings that are stored in resourced.
DEVICE_PACKAGE_OVERLAYS += device/semc/mango/overlay

PRODUCT_PACKAGES += KeyboardChanger

# These are the hardware-specific configuration files
PRODUCT_COPY_FILES += \
	device/semc/mango/prebuilt/media_profiles.xml:system/etc/media_profiles.xml

# Init files
PRODUCT_COPY_FILES += \
    device/semc/msm7x30-common/prebuilt/ueventd.mogami.rc:root/ueventd.mogami.rc \
    device/semc/msm7x30-common/prebuilt/init.mogami.rc:root/init.semc.rc \
    device/semc/mango/prebuilt/hw_config.sh:system/etc/hw_config.sh \
    device/semc/msm7x30-common/prebuilt/logo_M.rle:root/logo.rle \
    device/semc/mango/prebuilt/bootrec:root/sbin/bootrec \
    device/semc/mango/recovery.fstab:root/recovery.fstab 

#recovery resources
PRODUCT_COPY_FILES += \
    bootable/recovery/res/images/icon_clockwork.png:root/res/images/icon_clockwork.png \
    bootable/recovery/res/images/icon_error.png:root/res/images/icon_error.png \
    bootable/recovery/res/images/icon_installing.png:root/res/images/icon_installing.png \
    bootable/recovery/res/images/indeterminate1.png:root/res/images/indeterminate1.png \
    bootable/recovery/res/images/indeterminate2.png:root/res/images/indeterminate2.png \
    bootable/recovery/res/images/indeterminate3.png:root/res/images/indeterminate3.png \
    bootable/recovery/res/images/indeterminate4.png:root/res/images/indeterminate4.png \
    bootable/recovery/res/images/indeterminate5.png:root/res/images/indeterminate5.png \
    bootable/recovery/res/images/indeterminate6.png:root/res/images/indeterminate6.png \
    bootable/recovery/res/images/progress_empty.png:root/res/images/progress_empty.png \
    bootable/recovery/res/images/progress_fill.png:root/res/images/progress_fill.png


#WIFI modules and configs
PRODUCT_COPY_FILES += \
    device/semc/msm7x30-common/prebuilt/tiap_loader.sh:system/bin/tiap_loader.sh \
    device/semc/msm7x30-common/prebuilt/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf \
    device/semc/msm7x30-common/prebuilt/hostapd.conf:system/etc/wifi/softap/hostapd.conf \
    device/semc/msm7x30-common/modules/sdio.ko:root/modules/sdio.ko \
    device/semc/msm7x30-common/modules/tiap_drv.ko:root/modules/tiap_drv.ko \
    device/semc/msm7x30-common/modules/tiwlan_drv.ko:root/modules/tiwlan_drv.ko 

# mango uses MDPI artwork where available
PRODUCT_LOCALES += mdpi

#Offline charging animation
PRODUCT_COPY_FILES += \
    device/semc/msm7x30-common/prebuilt/animations/charging_animation_01_M.png:system/semc/chargemon/data/charging_animation_01.png \
    device/semc/msm7x30-common/prebuilt/animations/charging_animation_02_M.png:system/semc/chargemon/data/charging_animation_02.png \
    device/semc/msm7x30-common/prebuilt/animations/charging_animation_03_M.png:system/semc/chargemon/data/charging_animation_03.png \
    device/semc/msm7x30-common/prebuilt/animations/charging_animation_04_M.png:system/semc/chargemon/data/charging_animation_04.png \
    device/semc/msm7x30-common/prebuilt/animations/charging_animation_05_M.png:system/semc/chargemon/data/charging_animation_05.png \
    device/semc/msm7x30-common/prebuilt/animations/charging_animation_06_M.png:system/semc/chargemon/data/charging_animation_06.png \
    device/semc/msm7x30-common/prebuilt/animations/charging_animation_07_M.png:system/semc/chargemon/data/charging_animation_07.png \
    device/semc/msm7x30-common/prebuilt/animations/charging_animation_blank_M.png:system/semc/chargemon/data/charging_animation_blank.png

PRODUCT_PROPERTY_OVERRIDES += \
    rild.libpath=/system/lib/libril-qc-1.so \
    rild.libargs=-d/dev/smd0 \
    ro.ril.hsxpa=1 \
    ro.ril.gprsclass=10 \
    ro.telephony.default_network=0 \
    ro.telephony.call_ring.multiple=false \
    ro.telephony.ril_class=semc \
    wifi.interface=tiwlan0 \
    wifi.supplicant_scan_interval=15 \
    ro.sf.lcd_density=160 \
    keyguard.no_require_sim=true \
    ro.com.google.locationfeatures=1 \
    dalvik.vm.dexopt-flags=m=y \
    dalvik.vm.heapsize=32m \
    dalvik.vm.dexopt-data-only=1 \
    dalvik.vm.lockprof.threshold=500 \
    dalvik.vm.execution-mode=int:jit \
    dalvik.vm.checkjni=false \
    ro.opengles.version=131072  \
    ro.compcache.default=0 \
    ro.product.locale.language=en \
    ro.product.locale.region=US \
    persist.ro.ril.sms_sync_sending=1 \
    ro.use_data_netmgrd=true \
    wifi.hotspot.ti=1\
    BUILD_UTC_DATE=0

# Theme Selection
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.themeId=JellyBean \
    persist.sys.themePackageName=com.achep.theme.JellyBean

$(call inherit-product-if-exists, vendor/samsung/cooperve/cooperve-vendor.mk)
PRODUCT_COPY_FILES += $(call find-copy-subdir-files,*,device/gingerdx-common/prebuilt/system,system)  
