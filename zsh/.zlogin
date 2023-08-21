# ログイン時のメッセージ
echo "Welcome, $USER!"

# システムの再起動が必要かどうかをチェック
if [ -f /var/run/reboot-required ]; then
    echo "Reboot is required"
else
    echo "No reboot required"
fi

# ホスト名の取得
HOSTNAME=$(uname -n)

# カーネル情報の取得
KERNEL=$(uname -r)

# 起動時間の取得
UPTIME=$(uptime -p | sed 's/up //')

# CPU温度の取得（小数点を切り捨て）
CPU_TEMP=$(sensors | grep 'Tctl:' | awk '{print $2}' | sed 's/+//;s/°C//;s/\..*//')

# 現在の日時の取得
DATETIME=$(date)

# ダッシュボード表示
echo "==========================================="
echo "Hostname:   $HOSTNAME"
echo "Kernel:     $KERNEL"
echo "Uptime:     $UPTIME"
echo "CPU Temp:   $CPU_TEMP°C"
echo "Date/Time:  $DATETIME"
echo "==========================================="

# echo ""
# for ((i = 1; i <= 9; i++)); do
#     printf '\e[%dm%d\e[m ' $i $i
# done
# echo ""
# for ((i = 30; i <= 37; i++)); do
#     printf '\e[%dm%d\e[m ' $i $i
# done
# echo ""
# for ((i = 40; i <= 47; i++)); do
#     printf '\e[%dm%d\e[m ' $i $i
# done
# echo ""
# for ((i = 0; i < 16; i++)); do
#     for ((j = 0; j < 16; j++)); do
#         hex=$(($i*16 + $j))
#         printf '\e[38;5;%dm0x%02X\e[m ' $hex $hex
#     done
#     echo "";
# done
# echo ""
# for ((i = 0; i < 16; i++)); do
#     for ((j = 0; j < 16; j++)); do
#         hex=$(($i*16 + $j))
#         printf '\e[48;5;%dm0x%02X\e[m ' $hex $hex
#     done
#     echo "";
# done
# echo ""