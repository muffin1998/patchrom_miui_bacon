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
local-phone-apps := Camera2 Bluetooth HTMLViewer KeyChain LatinIME NfcNci PacProcessor \
        UserDictionaryProvider WAPPushManager ConfigPanel CertInstaller qcrilmsgtunnel QuickBoot \
	Stk TimeService PrintSpooler DocumentsUI BluetoothExt

local-phone-priv-apps := BackupRestoreConfirmation DefaultContainerService FusedLocation \
        ExternalStorageProvider InputDevices ProxyHandler SharedStorageBackup Shell TagGoogle \
        VpnDialogs com.qualcomm.location SettingsProvider MediaProvider ThemesProvider \
        DownloadProvider PicoTts Shell WallpaperCropper 

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

# The local targets after the zip file is generated, could include 'zip2sd' to 
# deliver the zip file to phone, or to customize other actions

include $(PORT_BUILD)/porting.mk

#Some Fix
local-pre-zip-misc:
		#rm stockrom fonts
		rm -rf $(ZIP_DIR)/system/fonts/*
		#copy files
		cp other/boot.img $(ZIP_DIR)/boot.img
		cp -a -rf other/system/* $(ZIP_DIR)/system/
		#fix selinux
		sed -i '4asetenforce 0' $(ZIP_DIR)/system/bin/sysinit
		#fix mdnsd
		-mv -f $(ZIP_DIR)/system/bin/mdnsd $(ZIP_DIR)/system/bin/mdnsd_vendor
		#fix stuck at "Sleep on..."
		rm -rf $(ZIP_DIR)/system/bin/app_process_vendor
		cp -rf stockrom/system/bin/app_process $(ZIP_DIR)/system/bin/app_process
		rm -rf $(ZIP_DIR)/system/bin/dexopt_vendor
		cp -rf stockrom/system/bin/dexopt $(ZIP_DIR)/system/bin/dexopt
