sed -i 's/192.168.1.1/192.168.23.1/g' package/base-files/files/bin/config_generate
sed -i "s/192\.168\.[0-9]*\.[0-9]*/192.168.23.1/g" $(find ./feeds/luci/modules/luci-mod-system/ -type f -name "flash.js")
sed -i 's/ImmortalWrt/OpenWrt/g' package/base-files/files/bin/config_generate
sed -i 's/ImmortalWrt/OpenWrt/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
#mv $GITHUB_WORKSPACE/patch/imm21.02/mac80211.sh $OPENWRT_PATH/package/kernel/mac80211/files/lib/wifi/mac80211.sh
mv $GITHUB_WORKSPACE/patch/immortalwrt-21.02/zz-diy-18.06 package/base-files/files/etc/uci-defaults/zz-diy
sed -i 's#downloads.immortalwrt.org#mirror.nju.edu.cn/immortalwrt#g' package/emortal/default-settings/files/99-default-settings-chinese
sed -i 's/ImmortalWrt/OpenWrt/g' include/version.mk

rm -rf feeds/luci/themes/luci-theme-argon
git clone -b 18.06 --depth 1 https://github.com/jerrykuku/luci-theme-argon.git feeds/luci/themes/luci-theme-argon
rm -rf feeds/luci/applications/luci-app-eqos
git clone --depth 1 https://github.com/wiwizcom/WiFiPortal.git package/WiFiPortal

# iStore
git clone --depth=1 -b main https://github.com/linkease/istore.git package/istore
git clone --depth=1 -b master https://github.com/linkease/nas-packages.git package/nas-packages
git clone --depth=1 -b main https://github.com/linkease/nas-packages-luci.git package/nas-luci
mv package/nas-packages/network/services/* package/nas-packages/
rm -rf package/nas-packages/network
