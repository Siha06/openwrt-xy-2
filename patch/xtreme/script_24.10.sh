#添加TurboAcc
# curl -sSL https://raw.githubusercontent.com/chenmozhijin/turboacc/luci/add_turboacc.sh -o add_turboacc.sh && bash add_turboacc.sh
# 修改默认IP，主机名
sed -i 's/192.168.1.1/192.168.23.1/g' package/base-files/files/bin/config_generate
sed -i "s/192\.168\.[0-9]*\.[0-9]*/192.168.23.1/g" $(find ./feeds/luci/modules/luci-mod-system/ -type f -name "flash.js")
sed -i 's/OpenWrt/Xtreme_Link/g' package/base-files/files/bin/config_generate

git clone --depth 1 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
git clone --depth 1 -b openwrt-24.10 https://github.com/immortalwrt/luci.git package/imm24-luci
rm -rf feeds/luci/modules
mv package/imm24-luci/modules feeds/luci/modules
sed -i 's/ImmortalWrt/Xtreme_Link/g' feeds/luci/modules/luci-mod-network/htdocs/luci-static/resources/view/network/wireless.js
rm -rf package/imm24-luci

mv $GITHUB_WORKSPACE/patch/xtreme/24.10/zz-diy package/base-files/files/etc/uci-defaults/zz-diy
mv $GITHUB_WORKSPACE/patch/xtreme/24.10/10_system.js feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/10_system.js
mv $GITHUB_WORKSPACE/patch/xtreme/24.10/mac80211.uc package/kernel/mac80211/files/lib/wifi/mac80211.uc

mv $GITHUB_WORKSPACE/patch/xtreme/bg1.jpg package/luci-theme-argon/htdocs/luci-static/argon/img/bg1.jpg
mv $GITHUB_WORKSPACE/patch/xtreme/argon.svg package/luci-theme-argon/htdocs/luci-static/argon/img/argon.svg
mv $GITHUB_WORKSPACE/patch/xtreme/24.10/footer.ut package/luci-theme-argon/ucode/template/themes/argon/footer.ut
mv $GITHUB_WORKSPACE/patch/xtreme/24.10/footer_login.ut package/luci-theme-argon/ucode/template/themes/argon/footer_login.ut

if grep -q "openclash=y" $GITHUB_WORKSPACE/$CONFIG_FILE; then
    echo "✅ 已选择 luci-app-openclash，添加 openclash core"
    mkdir -p files/etc/openclash/core
    # Download clash_meta
    META_URL="https://raw.githubusercontent.com/vernesong/OpenClash/core/master/meta/clash-linux-mips64.tar.gz"
    wget -qO- $META_URL | tar xOvz > files/etc/openclash/core/clash_meta
    chmod +x files/etc/openclash/core/clash_meta
    # 下载 GeoIP 和 GeoSite
    # wget -q https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat -O files/etc/openclash/GeoIP.dat
    # wget -q https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat -O files/etc/openclash/GeoSite.dat
else
    echo "⚪️ 未选择 luci-app-openclash"
fi
#完全删除luci版本
sed -i "s/+ ' \/ ' : '') + (luciversion ||/:/g" feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/10_system.js
#添加编译日期
sed -i "s/%C/\/ Complied on $(date +"%Y.%m.%d")/g" package/base-files/files/usr/lib/os-release
sed -i "s/%C/\/ Complied on $(date +"%Y.%m.%d")/g" package/base-files/files/etc/openwrt_release

rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 26.x feeds/packages/lang/golang
git clone --depth 1 https://github.com/vernesong/OpenClash.git package/OpenClash
git clone --depth 1 https://github.com/nikkinikki-org/OpenWrt-nikki.git package/OpenWrt-nikki
git clone --depth 1 https://github.com/Openwrt-Passwall/openwrt-passwall.git package/passwall
git clone --depth 1 https://github.com/Openwrt-Passwall/openwrt-passwall2.git package/passwall2
rm -rf feeds/luci/applications/{luci-app-passwall,luci-app-openclash}






