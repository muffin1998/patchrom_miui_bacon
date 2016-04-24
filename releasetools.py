import common
import edify_generator
import os
import re
import time
import copy


def AddBase(info):
    common.ZipWriteStr(info.output_zip, "file_contexts", info.input_zip.read("META/file_contexts"))
    common.ZipWriteStr(info.output_zip, "emmc_appsboot.mbn", info.input_zip.read("RADIO/emmc_appsboot.mbn"))
    common.ZipWriteStr(info.output_zip, "NON-HLOS.bin", info.input_zip.read("RADIO/NON-HLOS.bin"))
    common.ZipWriteStr(info.output_zip, "rpm.mbn", info.input_zip.read("RADIO/rpm.mbn"))
    common.ZipWriteStr(info.output_zip, "sbl1.mbn", info.input_zip.read("RADIO/sbl1.mbn"))
    common.ZipWriteStr(info.output_zip, "tz.mbn", info.input_zip.read("RADIO/tz.mbn"))
    common.ZipWriteStr(info.output_zip, "sdi.mbn", info.input_zip.read("RADIO/sdi.mbn"))
    common.ZipWriteStr(info.output_zip, "logo.bin", info.input_zip.read("RADIO/logo.bin"))
    common.ZipWriteStr(info.output_zip, "static_nvbk.bin", info.input_zip.read("RADIO/static_nvbk.bin"))

def InstallBase(info):
  info.script.AppendExtra('ui_print("Writing RADIO...");');
  info.script.AppendExtra('package_extract_file("emmc_appsboot.mbn", "/dev/block/platform/msm_sdcc.1/by-name/aboot");');
  info.script.AppendExtra('package_extract_file("rpm.mbn", "/dev/block/platform/msm_sdcc.1/by-name/rpm");');
  info.script.AppendExtra('package_extract_file("logo.bin", "/dev/block/platform/msm_sdcc.1/by-name/LOGO");');
  info.script.AppendExtra('package_extract_file("sdi.mbn", "/dev/block/platform/msm_sdcc.1/by-name/dbi");');
  info.script.AppendExtra('package_extract_file("tz.mbn", "/dev/block/platform/msm_sdcc.1/by-name/tz");');
  info.script.AppendExtra('package_extract_file("NON-HLOS.bin", "/dev/block/platform/msm_sdcc.1/by-name/modem");');
  info.script.AppendExtra('package_extract_file("static_nvbk.bin", "/dev/block/platform/msm_sdcc.1/by-name/oppostanvbk");');
  info.script.AppendExtra('package_extract_file("sbl1.mbn", "/dev/block/platform/msm_sdcc.1/by-name/sbl1");');

def FullOTA_InstallEnd(info):
    AddBase(info)
    InstallBase(info)
