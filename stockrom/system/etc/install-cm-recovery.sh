#!/system/bin/sh
if [ -f /system/etc/recovery-transform.sh ]; then
  exec sh /system/etc/recovery-transform.sh 8040448 057000cb1426353b818d81bbf8bc4cf82e5e15bf 6096896 07bf44168f13ac5ba28feb3895a6a9158bf86d63
fi

if ! applypatch -c EMMC:/dev/block/platform/msm_sdcc.1/by-name/recovery:8040448:057000cb1426353b818d81bbf8bc4cf82e5e15bf; then
  log -t recovery "Installing new recovery image"
  applypatch -b /system/etc/recovery-resource.dat EMMC:/dev/block/platform/msm_sdcc.1/by-name/boot:6096896:07bf44168f13ac5ba28feb3895a6a9158bf86d63 EMMC:/dev/block/platform/msm_sdcc.1/by-name/recovery 057000cb1426353b818d81bbf8bc4cf82e5e15bf 8040448 07bf44168f13ac5ba28feb3895a6a9158bf86d63:/system/recovery-from-boot.p
else
  log -t recovery "Recovery image already installed"
fi
