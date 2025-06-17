sed -i 's/192.168.1.1/192.168.10.99/g' package/base-files/files/bin/config_generate
sed -i "s/192\.168\.[0-9]*\.[0-9]*/192.168.10.99/g" $(find ./feeds/luci/modules/luci-mod-system/ -type f -name "flash.js")

mv $GITHUB_WORKSPACE/patch/virtualhere/199-diy.sh package/base-files/files/etc/uci-defaults/199-diy.sh
mv $GITHUB_WORKSPACE/patch/virtualhere/virtualhere package/base-files/files/etc/virtualhere
mv $GITHUB_WORKSPACE/patch/virtualhere/config.ini package/base-files/files/etc/virtualhere-config.ini
