#添加TurboAcc
# curl -sSL https://raw.githubusercontent.com/chenmozhijin/turboacc/luci/add_turboacc.sh -o add_turboacc.sh && bash add_turboacc.sh
# 修改默认IP，主机名
sed -i 's/192.168.1.1/192.168.23.1/g' package/base-files/files/bin/config_generate
sed -i "s/192\.168\.[0-9]*\.[0-9]*/192.168.23.1/g" $(find ./feeds/luci/modules/luci-mod-system/ -type f -name "flash.js")
sed -i 's/ImmortalWrt/OpenWrt/g' package/base-files/files/bin/config_generate
sed -i 's/ImmortalWrt/OpenWrt/g' package/network/config/wifi-scripts/files/lib/wifi/mac80211.uc
sed -i 's/ImmortalWrt/OpenWrt/g' include/version.mk
#mv $GITHUB_WORKSPACE/patch/banner package/base-files/files/etc/banner
mv $GITHUB_WORKSPACE/patch/immortalwrt-24.10/zz-diy package/base-files/files/etc/uci-defaults/zz-diy

# 小米4a千兆版
mv $GITHUB_WORKSPACE/patch/immortalwrt-24.10/r4a/mt7621_xiaomi_mi-router-4a-gigabit-v2.dts target/linux/ramips/dts/mt7621_xiaomi_mi-router-4a-gigabit-v2.dts
mv $GITHUB_WORKSPACE/patch/immortalwrt-24.10/r4a/mt7621_xiaomi_mi-router-4a-common.dtsi target/linux/ramips/dts/mt7621_xiaomi_mi-router-4a-common.dtsi
mv $GITHUB_WORKSPACE/patch/immortalwrt-24.10/r4a/mt7621.mk target/linux/ramips/image/mt7621.mk

#完全删除luci版本
sed -i "s/+ ' \/ ' : '') + (luciversion ||/:/g" feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/10_system.js
#添加编译日期
sed -i "s/%C/\/ Complied on $(date +"%Y.%m.%d")/g" package/base-files/files/usr/lib/os-release
sed -i "s/%C/\/ Complied on $(date +"%Y.%m.%d")/g" package/base-files/files/etc/openwrt_release

rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 25.x feeds/packages/lang/golang
git clone --depth 1 https://github.com/vernesong/OpenClash.git package/OpenClash
git clone --depth 1 https://github.com/nikkinikki-org/OpenWrt-nikki.git package/OpenWrt-nikki
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall.git package/passwall
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall2.git package/passwall2
rm -rf feeds/luci/applications/{luci-app-passwall,luci-app-openclash}
rm -rf feeds/packages/net/{mosdns,v2ray-geodata}
#rm -rf feeds/packages/utils/v2dat

git clone https://github.com/sbwml/luci-app-mosdns -b v5 package/mosdns
git clone https://github.com/sbwml/v2ray-geodata package/v2ray-geodata

#git clone --depth 1 https://github.com/sirpdboy/luci-app-netwizard package/luci-app-netwizard
#mv $GITHUB_WORKSPACE/patch/app/netwizard.lua package/luci-app-netwizard/luci-app-netwizard/luasrc/controller/netwizard.lua
