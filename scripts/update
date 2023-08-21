#!/bin/bash

# 対象のファイル一覧
zsh_dotfiles=(
    .zshrc
    .zshenv
    .zprofile
    .zlogin
    .zlogout
    .zsh_aliases
    # .zsh_history
)

# 選択肢の表示
choices=(
    "このファイルだけ置き換える"
    "このファイルは置き換えない"
    "すべてのファイルを置き換える"
    "以降のファイルの置き換えをスキップ"
)

choice=0

# メニュー描画関数
draw_menu() {
    clear
    echo -e "\033[1;34m"
    cat <<"EOF"
+------------+                   +---------------+            +---------------------+
|   Start    +------------------>+ zsh_dotfiles  |            |  Status Display     |
+-----+------+                   +-------+-------+            +----------+----------+
      |                                  |                               |                
      |   +------------------------------+                               |
      |   |                              |                               |
      | +---+        +---------+  +------+                               |
      +-+   |        | draw    |  |           +-----------+              |
        |   |        | menu()  +--+           | Prompt for|              |
        |   +------->+---------+              | config    |              |
        V                      +------------->+ update?   |              |
  +-----------+                     |         +-----------+              |
  | config    |                     |                                    |
  | whitelist |                     |                                    |
  +-----+-----+                     V                                    |
        |                    +-------------+                             |
        |                    | Option Logic|                             |
        +--------------------+------+------+                             |
                                    |                                    |
                                    V                                    |
                         +------+-------+                                |
                         | File Copy/   |<-------------------------------+
                         | Update       |
                         +--------------+

                                                          更新スプリクトのフロー
                                                        +--------------------+
                                                        - Created with by doremire

EOF
    echo -e "\033[0m"
    echo "$file はすでに存在します。どうしますか?"
    for i in "${!choices[@]}"; do
        if [ "$choice" -eq "$i" ]; then
            echo -e "\e[47;30m> ${choices[$i]}\e[0m"
        else
            echo "  ${choices[$i]}"
        fi
    done
}

replace_all=false
status_files=()

# 各ファイルに対して処理
for file in "${zsh_dotfiles[@]}"; do
    if [ -f $HOME/$file ]; then
        if [ -f $HOME/dotfiles/zsh/$file ] && [ "$replace_all" = false ]; then
            draw_menu
            while true; do
                # ユーザー入力を読み取る
                read -rsn3 key
                case $key in
                $'\x1b[A')
                    [ $choice -gt 0 ] && choice=$((choice - 1))
                    ;;
                $'\x1b[B')
                    [ $choice -lt $((${#choices[@]} - 1)) ] && choice=$((choice + 1))
                    ;;
                "")
                    case $choice in
                    0)
                        # ファイルを置き換える
                        cp $HOME/$file $HOME/dotfiles/zsh/
                        status_files+=("$file 🟢 Updated")
                        break
                        ;;
                    1)
                        # ファイルを置き換えない
                        status_files+=("$file 🔵 Unchanged")
                        break
                        ;;
                    2)
                        # 全てのファイルを置き換える
                        replace_all=true
                        for replace_file in "${zsh_dotfiles[@]}"; do
                            if [ -f $HOME/$replace_file ]; then
                                cp $HOME/$replace_file $HOME/dotfiles/zsh/
                                status_files+=("$replace_file 🟢 Updated")
                            else
                                status_files+=("$replace_file 🔴 File Not Found")
                            fi
                        done
                        break 2
                        ;;
                    3)
                        # 以降のファイルの置き換えをスキップ
                        replace_all=true
                        for skip_file in "${zsh_dotfiles[@]}"; do
                            if [[ ! " ${status_files[@]} " =~ " $skip_file " ]]; then
                                status_files+=("$skip_file 🟡 Skipped")
                            fi
                        done
                        break 2
                        ;;
                    esac
                    ;;
                esac
                draw_menu
            done
            choice=0 # 次のファイルのために選択をリセット
        else
            # ファイルが存在しない場合、置き換えて更新
            cp $HOME/$file $HOME/dotfiles/zsh/
            status_files+=("$file 🟢 Updated")
        fi
    else
        # ファイルが存在しない場合、ステータスに追加
        status_files+=("$file 🔴 File Not Found")
    fi
done

# 結果を表示
echo -e "\nファイルの状態："
for status in "${status_files[@]}"; do
    echo " - $status"
done

echo "zshの更新が完了しました"
read -p "configの更新をしますか？ (y/n): " execute

if [ "$execute" != "y" ]; then
    echo "スクリプトを中止しました。"
    exit
fi

config_dirs=(
    hypr
    wezterm
    mako
    swaylock
    waybar
    wlogout
    wofi
    neofetch
    starship
)

choices=(
    "このディレクトリだけ更新する"
    "このディレクトリは更新しない"
    "すべてのディレクトリを更新する"
    "以降のディレクトリの更新をスキップ"
)

choice=0

draw_menu() {
    clear
    echo "$dir はすでに存在します。どうしますか?"
    for i in "${!choices[@]}"; do
        if [ "$choice" -eq "$i" ]; then
            echo -e "\e[47;30m> ${choices[$i]}\e[0m"
        else
            echo "  ${choices[$i]}"
        fi
    done
}

replace_all=false
status_dirs=()

for dir in "${config_dirs[@]}"; do
    if [ -d $HOME/.config/$dir ]; then
        if [ -d $HOME/dotfiles/config/$dir ] && [ "$replace_all" = false ]; then
            draw_menu
            while true; do
                read -rsn3 key
                case $key in
                $'\x1b[A')
                    [ $choice -gt 0 ] && choice=$((choice - 1))
                    ;;
                $'\x1b[B')
                    [ $choice -lt $((${#choices[@]} - 1)) ] && choice=$((choice + 1))
                    ;;
                "")
                    case $choice in
                    0)
                        cp -r $HOME/.config/$dir $HOME/dotfiles/config/
                        status_dirs+=("$dir 🟢 Updated")
                        break
                        ;;
                    1)
                        status_dirs+=("$dir 🔵 Unchanged")
                        break
                        ;;
                    2)
                        replace_all=true
                        for replace_dir in "${config_dirs[@]}"; do
                            if [ -d $HOME/.config/$replace_dir ]; then
                                cp -r $HOME/.config/$replace_dir $HOME/dotfiles/config/
                                status_dirs+=("$replace_dir 🟢 Updated")
                            else
                                status_dirs+=("$replace_dir 🔴 Directory Not Found")
                            fi
                        done
                        break 2
                        ;;
                    3)
                        replace_all=true
                        for skip_dir in "${config_dirs[@]}"; do
                            if [[ ! " ${status_dirs[@]} " =~ " $skip_dir " ]]; then
                                status_dirs+=("$skip_dir 🟡 Skipped")
                            fi
                        done
                        break 2
                        ;;
                    esac
                    ;;
                esac
                draw_menu
            done
            choice=0 # Reset choice for the next directory
        else
            cp -r $HOME/.config/$dir $HOME/dotfiles/config/
            status_dirs+=("$dir 🟢 Updated")
        fi
    else
        status_dirs+=("$dir 🔴 Directory Not Found")
    fi
done

# 結果を表示
echo -e "\nディレクトリの状態："
for status in "${status_dirs[@]}"; do
    echo " - $status"
done
