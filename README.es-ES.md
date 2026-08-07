

# Instalar Passwall + núcleo Xray para OpenWrt en Xiaomi 4a Gigabit


## ✅ Versión de OpenWrt recomendada: 22.03.5

[//]: # ( 22.03.5 > https://downloads.openwrt.org/releases/22.03.5/targets/)

* [Versión de OpenWrt 22.03.3 recomendada (Haga clic para descargar)](https://archive.openwrt.org/releases/22.03.3/targets/ramips/mt7621/openwrt-22.03.3-ramips-mt7621-xiaomi_mi-router-4a-gigabit-squashfs-sysupgrade.bin)
* Si desea degradar la versión de OpenWrt, desmarque la opción "( Mantener configuración )" para realizar una instalación limpia.

## Instalación


### Ejecute este comando en la sesión SSH remota de OpenWrt

```
rm -f install_passwallx.sh && wget https://raw.githubusercontent.com/AmirhoseinArabhaji/Passwall-Xray-Xiaomi4aGigabit/main/install_passwallx.sh && chmod 777 install_passwallx.sh && sh install_passwallx.sh
```

¡Listo!

## Cómo funciona

Básicamente, este script instalará el núcleo xray en la RAM cada vez que reinicie su enrutador.
Esto es obligatorio porque el núcleo xray es demasiado grande para instalarse en la memoria flash del enrutador.

## Tipos compatibles


### Este script puede instalar uno de los siguientes núcleos:

| Protocolo    | XRAY | SING-BOX |
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

## Características


⚡ Instalación totalmente automática de paquetes en un solo paso

⚡ Instalar XRAY en espacio temporal si no dispone de suficiente espacio en disco (Inteligente)

⚡ Tráfico directo para IPs y dominios de IRAN (100%)

⚡ Mejorar el rendimiento

⚡ Conexión del servidor WARP corregida

⚡ Kill switch activado por defecto

## Por hacer


- [x] (Resolver errores) Obtenía algunos errores durante la instalación, pero funciona correctamente
- [x] Error al extraer el panel personalizado (iam.zip)
- [x] Renombrar `amir` y `amir2` con nombres apropiados
- [x] Actualizar los archivos `direct_ip` y `direct_host`


###
##### No dude en contribuir a este proyecto creando una solicitud de extracción (pull request).

## Créditos


Este script se basa en el trabajo de
[https://github.com/amirhosseinchoghaei/Passwall](https://github.com/amirhosseinchoghaei/Passwall)
pero incluye muchas mejoras y correcciones de errores, además de haber fusionado múltiples scripts de diferentes repositorios en uno solo.
