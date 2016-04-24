#
# Makefile for bacon
#

# The original zip file, MUST be specified by each product
local-zip-file     := stockrom.zip

# The output zip file of MIUI rom, the default is porting_miui.zip if not specified
local-out-zip-file := MIUI_bacon.zip

# the location for local-ota to save target-file
local-previous-target-dir := 

# All apps from original ZIP, but has smali files chanded
local-modified-apps := 

local-modified-jars :=

# All apks from MIUI
local-miui-removed-apps := 

local-miui-modified-apps := 

# All vendor apks needed
local-phone-apps := 

local-phone-priv-apps := 

local-density := XXHDPI

# The certificate for release version
local-certificate-dir := security

PORT_PRODUCT := bacon

# To include the local targets before and after zip the final ZIP file, 
# and the local-targets should:
# (1) be defined after including porting.mk if using any global variable(see porting.mk)
# (2) the name should be leaded with local- to prevent any conflict with global targets
local-pre-zip := local-pre-zip-misc
local-after-zip:= 

include phoneapps.mk

# The local targets after the zip file is generated, could include 'zip2sd' to 
# deliver the zip file to phone, or to customize other actions

include $(PORT_BUILD)/porting.mk

#Some Fix
local-pre-zip-misc:
		#fix fonts
		cp -a -f other/system/etc/fallback_fonts.xml $(ZIP_DIR)/system/etc/fallback_fonts.xml
		cp -a -f other/system/etc/system_fonts.xml $(ZIP_DIR)/system/etc/system_fonts.xml
                #some change
		echo "debug.sf.hw=1" >> $(ZIP_DIR)/system/build.prop
		#use patched boot.img
		cp other/boot.img $(ZIP_DIR)/boot.img
		#fix stuck at "Sleep on..."
		rm -rf $(ZIP_DIR)/system/bin/app_process_vendor
		cp -rf stockrom/system/bin/app_process $(ZIP_DIR)/system/bin/app_process
		rm -rf $(ZIP_DIR)/system/bin/dexopt_vendor
		cp -rf stockrom/system/bin/dexopt $(ZIP_DIR)/system/bin/dexopt
