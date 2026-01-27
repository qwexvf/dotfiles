#!/bin/bash

# Linux セキュリティチェックスクリプト
# Arch Linux向け

echo "=============================="
echo "Linux セキュリティチェックレポート"
echo "=============================="
echo ""

# 結果を保存する配列
declare -A results
declare -A check_points

# 1. カーネルのバージョン
echo "1. カーネルのバージョン:"
kernel_version=$(uname -r)
echo "$kernel_version"
results[1]="OK"
check_points[1]="-"
echo ""

# 2. アウトデートなパッケージ
echo "2. アウトデートなパッケージ:"
outdated_packages=$(checkupdates 2>/dev/null)
if [ -z "$outdated_packages" ]; then
    results[2]="OK"
    check_points[2]="-"
else
    echo "$outdated_packages"
    results[2]="needs to be checked"
    check_points[2]="上記のパッケージが更新可能です。sudo pacman -Syu で更新してください。"
fi
echo ""

# 3. ファイアウォールの状態
echo "3. ファイアウォールの状態:"
if command -v ufw &> /dev/null; then
    fw_status=$(sudo ufw status 2>/dev/null)
    echo "$fw_status"
    if echo "$fw_status" | grep -q "Status: active"; then
        results[3]="OK"
        check_points[3]="-"
    else
        results[3]="WARNING"
        check_points[3]="ファイアウォールが無効です。sudo ufw enable で有効化してください。"
    fi
elif command -v firewall-cmd &> /dev/null; then
    fw_status=$(sudo firewall-cmd --state 2>/dev/null)
    echo "$fw_status"
    if [ "$fw_status" = "running" ]; then
        results[3]="OK"
        check_points[3]="-"
    else
        results[3]="WARNING"
        check_points[3]="ファイアウォールが無効です。"
    fi
elif command -v iptables &> /dev/null; then
    fw_rules=$(sudo iptables -L -n 2>/dev/null | wc -l)
    if [ "$fw_rules" -gt 8 ]; then
        echo "iptables: ルールが設定されています"
        results[3]="OK"
        check_points[3]="-"
    else
        echo "iptables: 最小限のルールのみ"
        results[3]="needs to be checked"
        check_points[3]="iptablesのルールを確認してください。"
    fi
else
    echo "ファイアウォールが見つかりません"
    results[3]="WARNING"
    check_points[3]="ファイアウォールがインストールされていません。"
fi
echo ""

# 4. ディスクの暗号化状況
echo "4. ディスクの暗号化状況:"
lsblk_output=$(lsblk)
echo "$lsblk_output"
if echo "$lsblk_output" | grep -q "crypt"; then
    results[4]="OK"
    check_points[4]="-"
else
    results[4]="needs to be checked"
    check_points[4]="ディスク暗号化が検出されませんでした。必要に応じて設定してください。"
fi
echo ""

# 5. ミラーリポジトリ
echo "5. ミラーリポジトリ:"
if [ -f /etc/pacman.d/mirrorlist ]; then
    cat /etc/pacman.d/mirrorlist
    results[5]="OK"
    check_points[5]="-"
else
    echo "mirrorlistが見つかりません"
    results[5]="WARNING"
    check_points[5]="mirrorlistファイルが見つかりません。"
fi
echo ""

# 6. パスワードが設定されていないユーザー
echo "6. パスワードが設定されていないユーザー:"
no_password_users=$(sudo awk -F: '($2 == "" || $2 == "!") && $1 != "root" {print $1}' /etc/shadow 2>/dev/null)
if [ -z "$no_password_users" ]; then
    results[6]="OK"
    check_points[6]="-"
else
    echo "$no_password_users"
    results[6]="WARNING"
    check_points[6]="上記のユーザーにパスワードを設定してください。"
fi
echo ""

# 7. root以外でUID=0のユーザー
echo "7. root以外でUID=0のユーザー:"
uid0_users=$(awk -F: '($3 == 0) && ($1 != "root") {print $1}' /etc/passwd)
if [ -z "$uid0_users" ]; then
    results[7]="OK"
    check_points[7]="-"
else
    echo "$uid0_users"
    results[7]="WARNING"
    check_points[7]="root以外にUID=0のユーザーが存在します。セキュリティリスクです。"
fi
echo ""

# 8. 開いているポート
echo "8. 開いているポート:"
open_ports=$(ss -tlnp 2>/dev/null)
echo "$open_ports"

# 外部からアクセス可能なポート（127.0.0.1以外）をチェック
external_ports=$(ss -tlnp 2>/dev/null | grep -v "127.0.0.1" | grep -v "::1" | grep "LISTEN")
if [ -z "$external_ports" ]; then
    results[8]="OK"
    check_points[8]="-"
else
    results[8]="needs to be checked"
    check_points[8]="以下のポートが開いています。不要なサービスがないか確認してください。
$open_ports"
fi
echo ""

# 9. ClamAVのステータス
echo "9. ClamAVのステータス:"
if command -v clamd &> /dev/null; then
    systemctl status clamav-daemon.service 2>/dev/null
    systemctl status clamav-freshclam.service 2>/dev/null
    echo "ClamAVデータベースの更新:"
    sudo freshclam --quiet 2>&1 || freshclam 2>&1

    if systemctl is-active --quiet clamav-daemon.service; then
        results[9]="OK"
        check_points[9]="-"
    else
        results[9]="WARNING"
        check_points[9]="ClamAVデーモンが実行されていません。"
    fi
else
    echo "ClamAVがインストールされていません"
    results[9]="needs to be checked"
    check_points[9]="ClamAVがインストールされていません。必要に応じてインストールしてください。"
fi
echo ""

# まとめ
echo "=============================="
echo "チェック項目まとめ"
echo "=============================="

items=(
    "1:カーネル"
    "2:パッケージ"
    "3:ファイアウォール"
    "4:ディスク暗号化"
    "5:ミラーリポジトリ"
    "6:パスワードなしユーザー"
    "7:root以外のUID=0"
    "8:ポート"
    "9:ClamAV"
)

for item in "${items[@]}"; do
    num="${item%%:*}"
    name="${item##*:}"
    echo "$num. $name: ${results[$num]}"
    echo "  [確認ポイント] ${check_points[$num]}"
done

echo "=============================="
