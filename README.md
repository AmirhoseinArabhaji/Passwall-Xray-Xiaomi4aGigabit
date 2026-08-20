# Install Passwall + Xray core for Openwrt on Xiaomi 4a Gigabit


## ✅ Recommended Openwrt Version : 22.03.5

[//]: # ( 22.03.5 > https://downloads.openwrt.org/releases/22.03.5/targets/)

* [Openwrt version 22.03.3 Recommended (Click for download)](https://archive.openwrt.org/releases/22.03.3/targets/ramips/mt7621/openwrt-22.03.3-ramips-mt7621-xiaomi_mi-router-4a-gigabit-squashfs-sysupgrade.bin)
* when you want to downgrade openwrt please Uncheck ( Keep setting ) for clear installation.

## Installation


### Run this command in openwrt remote ssh

```
rm -f install_passwallx.sh && wget https://raw.githubusercontent.com/AmirhoseinArabhaji/Passwall-Xray-Xiaomi4aGigabit/main/install_passwallx.sh && chmod 777 install_passwallx.sh && sh install_passwallx.sh
```

Done !

⚠️ OpenWrt 24.10+ / 25.x are not supported by this script yet (different package manager, `apk` instead of `opkg`). Use 22.03.3–22.03.5.

## How It Works

Basically, this script will install the xray core on ram each time you reboot your router.
This is mandatory because the xray core is too big to be installed on the router's flash memory.

## Types Support


### This Script can install one of the following cores:

| Protocol    | XRAY | SING-BOX |
|-------------|------|----------|
| VLESS       | ✅    | ✅        |
| VMESS       | ✅    | ✅        |
| REALITY     | ✅    | ✅        |
| TROJAN      | ✅    | ✅        |
| HYSTERIA2   | ❌    | ✅        |
| TUC         | ❌    | ✅        |
| SHADOWSOCKS | ✅    | ✅        |
| WIREGUARD   | ✅    | ✅        |
| SOCKS       | ✅    | ✅        |
| HTTP        | ✅    | ✅        |

## Features


⚡ Full Automatic installation Packages Just in one step

⚡ Install XRAY On Temp Space if You Don't Have Enough Disk Space (Smart)

⚡ IRAN IP & Domain Traffic Direct (100%)

⚡ Improve Performance

⚡ Server WARP Connection Fixed

⚡ Default Kill Switch

## To Do


- [x] (Resolve Errors) I get some errors when installation, but it works fine
- [x] Error in extracting custom panel (iam.zip)
- [x] Rename `amir` and `amir2` to proper names
- [x] Update `direct_ip` and `direct_host` files
- [x] Fix dead `passwall.pub` signing key URL (mirrored in this repo as `passwall.pub` fallback)
- [x] Fix `dnsmasq` removal order (was removed after `luci-app-passwall` install, causing a file clash)
- [ ] Add OpenWrt 24.10+/25.x (apk) support

## Testing changes

The install script can be dry-run in an emulated OpenWrt 22.03.3 environment (real router rootfs, mipsel/QEMU-emulated, memory-capped) without touching real hardware — see [this guide](https://github.com/tonistiigi/binfmt) for the QEMU binfmt piece. Import the extracted squashfs rootfs from an official `.bin` firmware into Docker, register mipsel binfmt via `docker run --privileged --rm tonistiigi/binfmt --install mipsel`, then run the script inside a `--memory=128m` container to reproduce install-time failures before flashing a real device.

###
##### Feel free to contribute to this project by creating a pull request.

## Credits


This script is based on the work of
[https://github.com/amirhosseinchoghaei/Passwall](https://github.com/amirhosseinchoghaei/Passwall)
but it has lots of improvements and bug fixes and also merged multiple scripts from different repositories into one.