#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-op1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# 查看所有标签
#git tag
# 切换到标签 v24.10.5
git checkout v24.10.5

# 回退源码
#git reset --hard f372b71 #等同于切换到标签 v22.03.6

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default
# Add a feed source
#echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default

# 注释默认 packages
#sed -i 's/^\(.*packages\)/#&/' feeds.conf.default
# 添加 packages
#sed -i '$a src-git packages https://github.com/Lienol/openwrt-packages.git;24.10' feeds.conf.default
#sed -i '$a src-git packages https://github.com/openwrt/packages.git^c7d1a8c1ae976bd0ad94a351d82ee8fbf16a81f0' feeds.conf.default

# 注释默认 luci
#sed -i 's/^\(.*luci\)/#&/' feeds.conf.default
# 添加 luci
#sed -i '$a src-git luci https://github.com/Lienol/openwrt-luci.git;24.10' feeds.conf.default
#sed -i '$a src-git luci https://github.com/openwrt/luci.git^d6b13f648339273facc07b173546ace459c1cabe' feeds.conf.default

# 注释默认 routing
#sed -i 's/^\(.*routing\)/#&/' feeds.conf.default
# 添加 routing
#sed -i '$a src-git routing https://github.com/Lienol/openwrt-routing.git;24.10' feeds.conf.default
#sed -i '$a src-git routing https://github.com/openwrt/routing.git^85d040f28c21c116c905aa15a66255dde80336e7' feeds.conf.default

# 注释默认 telephony
#sed -i 's/^\(.*telephony\)/#&/' feeds.conf.default
# 添加 telephony
#sed -i '$a src-git telephony https://github.com/Lienol/openwrt-telephony.git;24.10' feeds.conf.default
#sed -i '$a src-git telephony https://github.com/openwrt/telephony.git^2a4541d46199ac96fac214d02c908402831c4dc6' feeds.conf.default

# 添加 lienol 大的 package
echo 'src-git lienol1 https://github.com/Lienol/openwrt-package.git;main' >>feeds.conf.default
echo 'src-git lienol2 https://github.com/Lienol/openwrt-package.git;other' >>feeds.conf.default

# 添加 luci-app-msd_lite
#echo 'src-git msd_lite https://github.com/iii80/luci-app-msd.git' >>feeds.conf.default
