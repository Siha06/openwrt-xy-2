sed -i 's/192.168.1.1/10.3.2.1/g' package/base-files/files/bin/config_generate
sed -i "s/192\.168\.[0-9]*\.[0-9]*/10.3.2.1/g" $(find ./feeds/luci/modules/luci-mod-system/ -type f -name "flash.js")
sed -i 's/ImmortalWrt/OpenWrt/g' package/base-files/files/bin/config_generate
sed -i 's/ImmortalWrt/OpenWrt/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
sed -i 's#downloads.immortalwrt.org#mirror.nju.edu.cn/immortalwrt#g' package/emortal/default-settings/files/99-default-settings-chinese
sed -i 's/ImmortalWrt/OpenWrt/g' include/version.mk

#mv $GITHUB_WORKSPACE/patch/immortalwrt-21.02/mac80211.sh $OPENWRT_PATH/package/kernel/mac80211/files/lib/wifi/mac80211.sh
mv $GITHUB_WORKSPACE/patch/immortalwrt-21.02/zz-diy-wifi package/base-files/files/etc/uci-defaults/zz-diy
#sed -i '/kmod-pcie_mhi/d' feeds/Siriling_modem/luci-app-modem/Makefile
# 小米4a千兆版
mv $GITHUB_WORKSPACE/patch/immortalwrt-21.02/dts/mt7621_xiaomi_mi-router-4a-gigabit-v2.dts target/linux/ramips/dts/mt7621_xiaomi_mi-router-4a-gigabit-v2.dts
mv $GITHUB_WORKSPACE/patch/immortalwrt-21.02/dts/mt7621_xiaomi_mi-router-4a-common.dtsi target/linux/ramips/dts/mt7621_xiaomi_mi-router-4a-common.dtsi
mv $GITHUB_WORKSPACE/patch/immortalwrt-21.02/image/mt7621.mk target/linux/ramips/image/mt7621.mk

#完全删除luci版本,缩减luci长度
sed -i "s/+ ' \/ ' : '') + (luciversion ||/:/g" feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/10_system.js
#sed -i "s/+ ' ' + luciversion.revision//" feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/10_system.js
#添加编译日期
sed -i "s/%C/\/ Complied on $(date +"%Y.%m.%d")/g" package/base-files/files/usr/lib/os-release
sed -i "s/%C/\/ Complied on $(date +"%Y.%m.%d")/g" package/base-files/files/etc/openwrt_release


#mv $GITHUB_WORKSPACE/patch/imm21.02/virtualhere/199-mydef.sh package/base-files/files/etc/uci-defaults/199-mydef.sh
#mv $GITHUB_WORKSPACE/patch/imm21.02/virtualhere/virtualhere package/base-files/files/etc/virtualhere
#mv $GITHUB_WORKSPACE/patch/imm21.02/virtualhere/config.ini package/base-files/files/etc/config.ini
