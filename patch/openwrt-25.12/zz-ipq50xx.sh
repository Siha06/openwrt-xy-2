#!/bin/sh
#uci set luci.main.mediaurlbase='/luci-static/bootstrap'
#uci commit luci

sed -i '/passwall/d' /etc/apk/repositories.d/distfeeds.list
sed -i '/qualcommax/d' /etc/apk/repositories.d/distfeeds.list
sed -i 's#downloads.openwrt.org#mirrors.pku.edu.cn/openwrt#g' /etc/apk/repositories.d/distfeeds.list
sed -i '$a https://mirrors.pku.edu.cn/openwrt/releases/25.12.0/targets/qualcommax/ipq50xx/kmods/6.12.71-1-592d0ef77704694d198540593694c92c/packages.adb' /etc/apk/repositories.d/distfeeds.list
sed -i '$a https://mirrors.pku.edu.cn/openwrt/releases/25.12.0/targets/qualcommax/ipq50xx/packages/packages.adb' /etc/apk/repositories.d/distfeeds.list


# wifi设置
uci set wireless.default_radio0.ssid=WiFi-$(cat /sys/class/ieee80211/phy0/macaddress|awk -F ":" '{print $5""$6 }' | tr 'a-z' 'A-Z')-2.4G
uci set wireless.radio0.txpower='20'
uci set wireless.default_radio1.ssid=WiFi-$(cat /sys/class/ieee80211/phy0/macaddress|awk -F ":" '{print $5""$6 }' | tr 'a-z' 'A-Z')-5G
uci set wireless.radio1.txpower='20'
uci commit wireless


uci commit

/etc/init.d/network restart >/dev/null 2>&1
exit 0
