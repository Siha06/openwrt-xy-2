
# 修改默认IP，主机名
sed -i 's/192.168.15.1/10.3.2.1/g' package/base-files/files/bin/config_generate
sed -i "s/192\.168\.[0-9]*\.[0-9]*/10.3.2.1/g" $(find ./feeds/luci/modules/luci-mod-system/ -type f -name "flash.js")
#sed -i 's/ImmortalWrt/OpenWrt/g' package/base-files/files/bin/config_generate
#sed -i 's/ImmortalWrt/OpenWrt/g' package/network/config/wifi-scripts/files/lib/wifi/mac80211.uc
#sed -i 's/ImmortalWrt/OpenWrt/g' include/version.mk
mv $GITHUB_WORKSPACE/patch/banner package/base-files/files/etc/banner
mv $GITHUB_WORKSPACE/patch/xwrt/zz-diy package/base-files/files/etc/uci-defaults/zz-diy

mkdir package/mypkg
git clone --depth 1 -b openwrt-24.10 https://github.com/immortalwrt/luci.git package/mypkg/imm24-luci
mv package/mypkg/imm24-luci/applications/luci-app-autoreboot package/mypkg/luci-app-autoreboot
mv package/mypkg/imm24-luci/applications/luci-app-ramfree package/mypkg/luci-app-ramfree
#rm -rf feeds/luci/modules
#mv package/mypkg/imm24-luci/modules feeds/luci/modules
rm -rf package/mypkg/imm24-luci
sed -i 's#../../luci.mk#$(TOPDIR)/feeds/luci/luci.mk#g' $(find ./package/mypkg/ -type f -name "Makefile")

#完全删除luci版本
sed -i "s/+ ' \/ ' : '') + (luciversion ||/:/g" feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/10_system.js
#添加编译日期
sed -i "s/%C/\/ Complied on $(date +"%Y.%m.%d")/g" package/base-files/files/usr/lib/os-release
sed -i "s/%C/\/ Complied on $(date +"%Y.%m.%d")/g" package/base-files/files/etc/openwrt_release

rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 24.x feeds/packages/lang/golang
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
