#!/bin/bash

OUTPUT=""
MARKDOWN=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    -o|--output)
      OUTPUT="$2"
      shift 2
      ;;
    -m|--markdown)
      MARKDOWN=1
      shift
      ;;
    *)
      shift
      ;;
  esac
done

DETAILS="==============================
Linux セキュリティチェックレポート
==============================

"

# 1. カーネルのバージョン
KERNEL_VERSION=$(uname -r)
DETAILS+="1. カーネルのバージョン:\n$KERNEL_VERSION\n\n"

# 2. アウトデートなパッケージ
if command -v pacman >/dev/null 2>&1; then
  OUTDATED_PACKAGES=$(pacman -Qu)
  DETAILS+="2. アウトデートなパッケージ:\n$OUTDATED_PACKAGES\n\n"
elif command -v apt >/dev/null 2>&1; then
  OUTDATED_PACKAGES=$(apt list --upgradable 2>/dev/null | grep -v "Listing...")
  DETAILS+="2. アウトデートなパッケージ:\n$OUTDATED_PACKAGES\n\n"
else
  OUTDATED_PACKAGES=""
  DETAILS+="2. アウトデートなパッケージ:\nパッケージマネージャーが見つかりません\n\n"
fi

# 3. ファイアウォール
if command -v ufw >/dev/null 2>&1; then
  FIREWALL_STATUS=$(sudo ufw status)
  DETAILS+="3. ファイアウォールの状態:\n$FIREWALL_STATUS\n\n"
elif command -v firewall-cmd >/dev/null 2>&1; then
  FIREWALL_STATUS=$(sudo firewall-cmd --state)
  DETAILS+="3. ファイアウォールの状態:\n$FIREWALL_STATUS\n\n"
else
  FIREWALL_STATUS=""
  DETAILS+="3. ファイアウォールの状態:\nufwやfirewalldが見つかりません\n\n"
fi

# 4. ディスク暗号化
ENCRYPTED=$(lsblk -o TYPE | grep crypt)
LSBLK_OUTPUT=$(lsblk)
DETAILS+="4. ディスクの暗号化状況:\n$LSBLK_OUTPUT\n\n"

# 5. ミラーリポジトリ
if [ -f /etc/pacman.d/mirrorlist ]; then
  MIRROR_OK=$(grep -E "Server = https?://.*" /etc/pacman.d/mirrorlist | head -n 1)
  MIRROR_OUTPUT=$(head -n 20 /etc/pacman.d/mirrorlist)
  DETAILS+="5. ミラーリポジトリ:\n$MIRROR_OUTPUT\n\n"
elif [ -f /etc/apt/sources.list ]; then
  MIRROR_OK=$(grep -E "^deb " /etc/apt/sources.list | head -n 1)
  MIRROR_OUTPUT=$(head -n 20 /etc/apt/sources.list)
  DETAILS+="5. ミラーリポジトリ:\n$MIRROR_OUTPUT\n\n"
else
  MIRROR_OK=""
  DETAILS+="5. ミラーリポジトリ:\nミラーリストファイルが見つかりません\n\n"
fi

# 6. パスワードなしユーザー
NO_PASS_USERS=$(sudo awk -F: '($2 == "") {print $1}' /etc/shadow)
DETAILS+="6. パスワードが設定されていないユーザー:\n$NO_PASS_USERS\n\n"

# 7. root以外でUID=0
NONROOT_UID0=$(awk -F: '($3 == "0" && $1 != "root") {print $1}' /etc/passwd)
DETAILS+="7. root以外でUID=0のユーザー:\n$NONROOT_UID0\n\n"

# 8. 開いているポート
if command -v ss >/dev/null 2>&1; then
  PORTS=$(ss -tulpn | grep LISTEN)
  PORTS_CMD="ss -tulpn"
  PORTS_OUTPUT="$PORTS"
elif command -v netstat >/dev/null 2>&1; then
  PORTS=$(netstat -tulpn | grep LISTEN)
  PORTS_CMD="netstat -tulpn"
  PORTS_OUTPUT="$PORTS"
else
  PORTS=""
  PORTS_CMD=""
  PORTS_OUTPUT="ssやnetstatが見つかりません"
fi
DETAILS+="8. 開いているポート:\n$PORTS_OUTPUT\n\n"

# 9. ClamAV
if systemctl list-units --type=service | grep -q clamav; then
  CLAMAV_STATUS=$(sudo systemctl is-active clamav-daemon.service 2>/dev/null)
  FRESHCLAM_STATUS=$(sudo systemctl is-active clamav-freshclam.service 2>/dev/null)
  CLAMAV_DAEMON_STATUS=$(sudo systemctl status clamav-daemon.service 2>&1)
  CLAMAV_FRESHCLAM_STATUS=$(sudo systemctl status clamav-freshclam.service 2>&1)
  FRESHCLAM_UPDATE=$(sudo freshclam 2>&1)
  DETAILS+="9. ClamAVのステータス:\n$CLAMAV_DAEMON_STATUS\n$CLAMAV_FRESHCLAM_STATUS\nClamAVデータベースの更新:\n$FRESHCLAM_UPDATE\n\n"
else
  CLAMAV_STATUS="not installed"
  FRESHCLAM_STATUS="not installed"
  DETAILS+="9. ClamAVのステータス:\nClamAVがインストールされていません\n\n"
fi

# チェックまとめ
if [[ $MARKDOWN -eq 1 ]]; then
  SUMMARY="\n## セキュリティチェック項目まとめ\n\n| 項目 | 結果 | 確認ポイント |\n|:---|:---|:---|\n"
else
  SUMMARY="\n==============================\nチェック項目まとめ\n==============================\n"
fi

# 1. カーネル
if [[ $MARKDOWN -eq 1 ]]; then
  SUMMARY+="| カーネル | OK | - |\n"
else
  SUMMARY+="1. カーネル: OK\n"
fi

# 2. アウトデートなパッケージ
if [[ -z "$OUTDATED_PACKAGES" ]]; then
  STATUS2="OK"
  ADVICE2="-"
else
  STATUS2="outdated"
  ADVICE2="アップデート可能なパッケージがあります。パッケージマネージャーで更新してください。"
fi
if [[ $MARKDOWN -eq 1 ]]; then
  SUMMARY+="| パッケージ | $STATUS2 | $ADVICE2 |\n"
else
  SUMMARY+="2. パッケージ: $STATUS2\n  [確認ポイント] $ADVICE2\n"
fi

# 3. ファイアウォール
if [[ "$FIREWALL_STATUS" == *"active"* || "$FIREWALL_STATUS" == "running" ]]; then
  STATUS3="OK"
  ADVICE3="-"
else
  STATUS3="needs to be checked"
  ADVICE3="ファイアウォールが有効になっていません。ufwやfirewalldの設定を確認してください。"
fi
if [[ $MARKDOWN -eq 1 ]]; then
  SUMMARY+="| ファイアウォール | $STATUS3 | $ADVICE3 |\n"
else
  SUMMARY+="3. ファイアウォール: $STATUS3\n  [確認ポイント] $ADVICE3\n"
fi

# 4. ディスク暗号化
if [[ -n "$ENCRYPTED" ]]; then
  STATUS4="OK"
  ADVICE4="-"
else
  STATUS4="needs to be checked"
  ADVICE4="lsblkでcryptパーティションがあるか確認してください。"
fi
if [[ $MARKDOWN -eq 1 ]]; then
  SUMMARY+="| ディスク暗号化 | $STATUS4 | $ADVICE4 |\n"
else
  SUMMARY+="4. ディスク暗号化: $STATUS4\n  [確認ポイント] $ADVICE4\n"
fi

# 5. ミラーリポジトリ
if [[ -n "$MIRROR_OK" ]]; then
  STATUS5="OK"
  ADVICE5="-"
else
  STATUS5="needs to be checked"
  ADVICE5="信頼できるミラーリポジトリを使用しているか確認してください。"
fi
if [[ $MARKDOWN -eq 1 ]]; then
  SUMMARY+="| ミラーリポジトリ | $STATUS5 | $ADVICE5 |\n"
else
  SUMMARY+="5. ミラーリポジトリ: $STATUS5\n  [確認ポイント] $ADVICE5\n"
fi

# 6. パスワードなしユーザー
if [[ -z "$NO_PASS_USERS" ]]; then
  STATUS6="OK"
  ADVICE6="-"
else
  STATUS6="needs to be checked"
  ADVICE6="sudo awk -F: '(\$2 == \"\") {print \$1}' /etc/shadow で該当ユーザーを確認し、パスワードを設定してください。"
fi
if [[ $MARKDOWN -eq 1 ]]; then
  SUMMARY+="| パスワードなしユーザー | $STATUS6 | $ADVICE6 |\n"
else
  SUMMARY+="6. パスワードなしユーザー: $STATUS6\n  [確認ポイント] $ADVICE6\n"
fi

# 7. root以外のUID=0
if [[ -z "$NONROOT_UID0" ]]; then
  STATUS7="OK"
  ADVICE7="-"
else
  STATUS7="needs to be checked"
  ADVICE7="/etc/passwdでUID=0のユーザーがroot以外にいないか確認してください。"
fi
if [[ $MARKDOWN -eq 1 ]]; then
  SUMMARY+="| root以外のUID=0 | $STATUS7 | $ADVICE7 |\n"
else
  SUMMARY+="7. root以外のUID=0: $STATUS7\n  [確認ポイント] $ADVICE7\n"
fi

# 8. 怪しいポート
if [[ -n "$PORTS" ]]; then
  STATUS8="needs to be checked"
  ADVICE8="以下のポートが開いています。不要なサービスがないか確認してください。\n$PORTS_OUTPUT"
else
  STATUS8="OK"
  ADVICE8="-"
fi
if [[ $MARKDOWN -eq 1 ]]; then
  SUMMARY+="| ポート | $STATUS8 | $( [[ $STATUS8 == "needs to be checked" ]] && echo "\`$PORTS_OUTPUT\`" || echo "-" ) |\n"
else
  SUMMARY+="8. ポート: $STATUS8\n  [確認ポイント] $ADVICE8\n"
fi

# 9. ClamAV
if [[ "$CLAMAV_STATUS" == "active" && "$FRESHCLAM_STATUS" == "active" ]]; then
  STATUS9="OK"
  ADVICE9="-"
else
  STATUS9="needs to be checked"
  ADVICE9="ClamAVがインストール・有効化されているか、freshclamで定義ファイルが最新か確認してください。"
fi
if [[ $MARKDOWN -eq 1 ]]; then
  SUMMARY+="| ClamAV | $STATUS9 | $ADVICE9 |\n"
else
  SUMMARY+="9. ClamAV: $STATUS9\n  [確認ポイント] $ADVICE9\n"
fi

if [[ $MARKDOWN -eq 1 ]]; then
  SUMMARY+="\n---\n"
else
  SUMMARY+="==============================\n"
fi

# Output to file or stdout
if [[ -n "$OUTPUT" ]]; then
  echo -e "$DETAILS$SUMMARY" > "$OUTPUT"
  echo "Report written to $OUTPUT"
else
  echo -e "$DETAILS$SUMMARY"
fi
