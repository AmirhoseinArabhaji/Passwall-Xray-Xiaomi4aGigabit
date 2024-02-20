# Install Passwall + Xray core for Openwrt on Xiaomi 4a Gigabit

---

## ✅ Recommended Openwrt Version : 22.03.5

[//]: # ( 22.03.5 > https://downloads.openwrt.org/releases/22.03.5/targets/)

* [Openwrt version 22.03.3 Recommended (Click for download)](https://archive.openwrt.org/releases/22.03.3/targets/ramips/mt7621/openwrt-22.03.3-ramips-mt7621-xiaomi_mi-router-4a-gigabit-squashfs-sysupgrade.bin)
* when you want to downgrade openwrt please Uncheck ( Keep setting ) for clear installation.

## Installation

---

### Run this command in openwrt remote ssh

```
rm -f install_passwallx.sh && wget https://raw.githubusercontent.com/AmirhoseinArabhaji/Passwall/main/install_passwallx.sh && chmod 777 install_passwallx.sh && sh install_passwallx.sh
```

Done !

## How It Works

Basically, this script will install the xray core on ram each time you reboot your router.
This is mandatory because the xray core is too big to be installed on the router's flash memory.

## Types Support

---

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

---

⚡ Full Automatic installation Packages Just in one step

⚡ Install XRAY On Temp Space if You Don't Have Enough Disk Space (Smart)

⚡ IRAN IP & Domain Traffic Direct (100%)

⚡ Improve Performance

⚡ Server WARP Connection Fixed

⚡ Default Kill Switch

## To Do

---

- [x] (Resolve Errors) I get some errors when installation, but it works fine
- [x] Error in extracting custom panel (iam.zip)
- [x] Rename `amir` and `amir2` to proper names
- [x] Update `direct_ip` and `direct_host` files


###
##### Feel free to contribute to this project by creating a pull request.

## Credits

---

This script is based on the work of
[https://github.com/amirhosseinchoghaei/Passwall](https://github.com/amirhosseinchoghaei/Passwall)
but it has lots of improvements and bug fixes and also merged multiple scripts from different repositories into one.