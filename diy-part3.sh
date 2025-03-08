#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# 汇总常用插件

function merge_package() {
    # 参数1是分支名,参数2是库地址,参数3是所有文件下载到指定路径。
    # 同一个仓库下载多个文件夹直接在后面跟文件名或路径，空格分开。
    if [[ $# -lt 3 ]]; then
    	echo "Syntax error: [$#] [$*]" >&2
        return 1
    fi
    trap 'rm -rf "$tmpdir"' EXIT
    branch="$1" curl="$2" target_dir="$3" && shift 3
    rootdir="$PWD"
    localdir="$target_dir"
    [ -d "$localdir" ] || mkdir -p "$localdir"
    tmpdir="$(mktemp -d)" || exit 1
    git clone -b "$branch" --depth 1 --filter=blob:none --sparse "$curl" "$tmpdir"
    cd "$tmpdir"
    git sparse-checkout init --cone
    git sparse-checkout set "$@"
    # 使用循环逐个移动文件夹
    for folder in "$@"; do
        mv -f "$folder" "$rootdir/$localdir"
    done
    cd "$rootdir"
}

# 依赖
merge_package master https://github.com/coolsnowwolf/packages package/app multimedia/pppwn-cpp
merge_package openwrt-24.10 https://github.com/immortalwrt/packages package/app net/msd_lite
merge_package main https://github.com/nikkinikki-org/OpenWrt-nikki package/app nikki
merge_package main https://github.com/nikkinikki-org/OpenWrt-nikki package/app luci-app-nikki
merge_package main https://github.com/gdy666/luci-app-lucky package/app lucky
merge_package main https://github.com/gdy666/luci-app-lucky package/app luci-app-lucky
# merge_package main https://github.com/sirpdboy/luci-app-lucky package/app luci-app-lucky
# merge_package main https://github.com/sirpdboy/luci-app-lucky package/app lucky

# 软件包
merge_package main https://github.com/kenzok8/small-package package/app luci-app-adguardhome
merge_package v5 https://github.com/sbwml/luci-app-mosdns package/app luci-app-mosdns mosdns v2dat
merge_package main https://github.com/kenzok8/small-package package/app luci-app-fileassistant
git clone -b js --depth 1 https://github.com/UnblockNeteaseMusic/luci-app-unblockneteasemusic.git package/app/luci-app-unblockneteasemusic
git clone -b master https://github.com/sbwml/luci-app-qbittorrent package/app/qbittorrent
git clone https://github.com/xiaorouji/openwrt-passwall-packages.git package/app/passwall_packages
merge_package main https://github.com/xiaorouji/openwrt-passwall2 package/app luci-app-passwall2
merge_package main https://github.com/xiaorouji/openwrt-passwall package/app luci-app-passwall
merge_package dev https://github.com/vernesong/OpenClash package/app luci-app-openclash



# echo '### Argon Theme Config ###'
# rm -rf feeds/luci/themes/luci-theme-argon
git clone -b master  https://github.com/jerrykuku/luci-theme-argon.git feeds/luci/themes/luci-theme-argon
# rm -rf feeds/luci/applications/luci-app-argon-config # if have
git clone https://github.com/jerrykuku/luci-app-argon-config.git feeds/luci/applications/luci-app-argon-config

./scripts/feeds update -a
./scripts/feeds install -a

