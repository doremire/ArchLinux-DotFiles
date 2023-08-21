# Created by newuser for 5.9
eval "$(starship init zsh)"
eval $(thefuck --alias)
eval "$(zoxide init zsh)"

# .zshrcの例

# .zsh_aliasesファイルを読み込む
if [ -f ~/.zsh_aliases ]; then
    source ~/.zsh_aliases
fi

# 連想配列aliasesの中身をループしてエイリアスを追加
for alias_def in "${alias_arr[@]}"; do
    alias "${alias_def}"
done

# -------------------------------------------------------
#      setting....
# -------------------------------------------------------
#

autoload -Uz compinit promptinit
compinit
promptinit

# デフォルトのプロンプトを walters テーマに設定する
# prompt walters

# コマンド履歴の管理ファイル
HISTFILE=~/.zsh_history
# メモリに保存する履歴のサイズ
export HISTSIZE=10000
# ファイルに保存する履歴のサイズ
export SAVEHIST=100000
# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# コマンドのスペルを訂正
setopt correct
# 補完候補を詰めて表示
setopt list_packed
## 他のzshと履歴を共有
setopt inc_append_history
setopt share_history
## パスを直接入力してもcdする
setopt AUTO_CD
# 補完候補をカーソルで選択
zstyle ':completion:*:default' menu select=1
# スラッシュを単語の区切りと見なす
autoload -Uz select-word-style
select-word-style bash
WORDCHARS='.-'
# ヒストリーに重複を表示しない
setopt hist_ignore_all_dups
# 重複するコマンドが保存されるとき、古い方を削除する。
setopt hist_save_no_dups
# コマンドのタイムスタンプをHISTFILEに記録する
setopt extended_history
# HISTFILEのサイズがHISTSIZEを超える場合、最初に重複を削除
setopt hist_expire_dups_first
# コマンドラインでも # 以降をコメントと見なす
setopt interactive_comments
# LSDで使用されるカラーを変更(ディレクトリのみ変更)
export LS_COLORS="di=36"

# Download Znap, if it's not there yet.
[[ -r ~/Repos/znap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/Repos/znap
source ~/Repos/znap/znap.zsh # Start Znap

znap source marlonrichert/zsh-autocomplete

znap source zsh-users/zsh-autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=7"

znap source zdharma/fast-syntax-highlighting


mkcd() {
    mkdir -p "$1"
    cd "$1" || return
}

mkfile() {
    local dir
    dir=$(dirname "$1")

    # ディレクトリが存在しない場合、作成
    if [ ! -d "$dir" ]; then
        mkdir -p "$dir"
        echo -e "\e[32m\e[0m ディレクトリ $dir を作成しました。"

        print -n "\e[34m\e[0m '$dir' に移動しますか？ [y/N] "
        read -k 1 resp
        echo "" # キャラクター入力後の改行のため
    fi

    # ファイルが既に存在する場合、通知
    if [ -f "$1" ]; then
        echo -e "\e[33m\e[0m ファイル $1 は既に存在しています。"
    else
        # ファイルを作成
        touch "$1"
        echo -e "\e[32m\e[0m ファイル $1 を作成しました。"
    fi

    # ユーザーの選択に応じてディレクトリに移動
    case "$resp" in
    [yY])
        cd "$dir" || return
        ;;
    *)
        # 必要に応じてメッセージを表示（今回は何も表示しない）
        ;;
    esac
}
