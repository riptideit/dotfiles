# ----- Oh My Zsh base -----
export ZSH="$HOME/.config/zsh/oh-my-zsh"
ZSH_THEME=""   # disable theme; Starship will render the prompt

plugins=(
  git
  z
  extract
  sudo
  command-not-found
  colored-man-pages
  docker
  npm
  node
  python
  pip
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source "$ZSH/oh-my-zsh.sh"

# ==================== YOUR CUSTOM CONFIGURATION ====================

# Aliases: editor
alias e="$EDITOR"
alias E="sudo -e"

# Aliases: ls (eza)
alias l='eza -1A --group-directories-first --color=always --git-ignore'
alias ls='l'
alias la='l -l --time-style="+%Y-%m-%d %H:%M" --no-permissions --octal-permissions'
alias tree='l --tree'

# Git
alias ga='git add'
alias gap='ga --patch'
alias gb='git branch'
alias gba='gb --all'
alias gc='git commit'
alias gca='gc --amend --no-edit'
alias gce='gc --amend'
alias gco='git checkout'
alias gcl='git clone --recursive'
alias gd='git diff --output-indicator-new=" " --output-indicator-old=" "'
alias gds='gd --staged'
alias gi='git init'
alias gl='git log --graph --all --pretty=format:"%C(magenta)%h %C(white) %an  %ar%C(auto)  %D%n%s%n"'
alias gm='git merge'
alias gn='git checkout -b'
alias gp='git push'
alias gr='git reset'
alias gs='git status --short'
alias gu='git pull'
unalias gcm 2>/dev/null
gcm() { git commit --message "$*"; }

# Docker
alias dps='docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"'
alias dl='docker logs --tail=100'
alias dc='docker compose'

# Tmux
alias ta='tmux attach'
alias tl='tmux list-sessions'
alias tn='tmux new-session -s'

# ripgrep
alias rg="rg --hidden --smart-case --glob='!.git/' --no-search-zip --trim --colors=line:fg:black --colors=line:style:bold --colors=path:fg:magenta --colors=match:style:nobold"

# pass
alias pa='pass'
alias pac='pass -c'
alias po='pass otp'
alias poc='pass otp -c'
alias pg='openssl rand -base64 33'

# systemd
alias sd='sudo systemctl'
alias sdu='systemctl --user'
alias jd='journalctl --no-pager'

# misc utils
alias cal='TZ=Asia/Bangkok cal --monday'
alias du='du --human-readable'
alias free='free --human'
alias cp='cp --interactive'
alias mv='mv --interactive'
alias pipi='pip install'
alias pipig='pip install "git+https://github.com/user/repo.git"'
mk() { mkdir --parents "$1" && cd "$1"; }
alias rf='rm -rf'
alias py='python3'
alias ipy='ipython'
alias ping='ping -A'
alias -g p='2>&1 | less'
alias sudo='sudo '  # allow aliases with sudo

# package managers
if [[ -n "$TERMUX_VERSION" ]]; then
  alias pi='pkg install'
  alias pf='pkg search'
  alias pr='pkg uninstall'
else
  alias pi='sudo pacman -S --needed'
  alias pf='pacman -Ss'
  alias pr='sudo pacman -Rs'
fi
alias pu='sudo pacman -Sy --needed archlinux-keyring && sudo pacman -Su'

# ledger / when / notes repos
alias lg='ledger'
alias lga='ledger accounts'
alias lgb='ledger balance'
alias lgr='ledger register'
alias wi='TZ=Asia/Bangkok when ci --future=30'
alias ew='when eci'
alias en='e ~/notes/'
alias el='e ~/.ledger/journal.ldg'
alias git-notes='git -C ~/notes'
alias git-when='git -C ~/.when'
alias git-ledger='git -C ~/.ledger'
alias sync-commit-notes='git-notes add --all; git-notes commit --message sync; git-notes pull; git-notes push'
alias cj-pull='pass git pull; git-notes pull; git-when pull; git-ledger pull'
alias cj-status='pass git status; git-notes status; git-when status; git-ledger status'

# man colors
man() {
  GROFF_NO_SGR=1 \
  LESS_TERMCAP_mb=$'\e[31m' \
  LESS_TERMCAP_md=$'\e[34m' \
  LESS_TERMCAP_me=$'\e[0m' \
  LESS_TERMCAP_se=$'\e[0m' \
  LESS_TERMCAP_so=$'\e[1;30m' \
  LESS_TERMCAP_ue=$'\e[0m' \
  LESS_TERMCAP_us=$'\e[35m' \
  command man "$@"
}

# ZLE / editor / history
KEYTIMEOUT=1
WORDCHARS='-_:'
setopt interactive_comments
setopt auto_continue check_jobs check_running_jobs
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST="$HISTSIZE"
setopt extended_history inc_append_history inc_append_history_time share_history hist_fcntl_lock
setopt hist_ignore_dups hist_ignore_all_dups hist_save_no_dups hist_ignore_space hist_reduce_blanks hist_no_store
HISTORY_IGNORE='(rm *|rf *)'
__history() { LBUFFER="$(fc -ln 0 | fzf --query="${LBUFFER}")"; zle redisplay; }
zle -N __history

# Completion
LISTMAX=10000
setopt glob_dots hash_cmds list_packed
autoload -Uz compinit
compinit -C
zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*' menu select
zstyle ':completion:*' increment yes
zstyle ':completion:*' verbose yes
zstyle ':completion:*' squeeze-slashes yes
zstyle ':completion:*' file-sort modification
zstyle ':completion:*' list-dirs-first yes
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' ignored-patterns '.git'
zstyle ':completion:*' rehash false
zstyle ':completion:*' use-cache true

# Keyboard
unsetopt flow_control
bindkey -e
bindkey '^I' complete-word
bindkey '^[[3~' delete-char
bindkey '^[[Z' reverse-menu-complete
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
bindkey '^R' __history
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^S' edit-command-line
fg-ctrl-z () { fg 2> /dev/null }
zle -N fg-ctrl-z
bindkey '^Z' fg-ctrl-z

# Autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#606090'
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=40

# Syntax highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
ZSH_HIGHLIGHT_MAXLENGTH=120
ZSH_HIGHLIGHT_STYLES[bracket-level-1]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[bracket-level-2]='fg=green'
ZSH_HIGHLIGHT_STYLES[bracket-level-3]='fg=blue'
ZSH_HIGHLIGHT_STYLES[bracket-level-4]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[bracket-level-5]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[bracket-level-6]='fg=red'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red,underline'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=blue'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[global-alias]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[arg0]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=green'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=green'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[path]='none'

# Optional tools
if command -v zoxide &> /dev/null; then
  export _ZO_FZF_OPTS="$FZF_DEFAULT_OPTS --no-tac --select-1 --exit-0"
  eval "$(zoxide init zsh --no-cmd)"
  alias z='__zoxide_zi'
  alias ~='cd ~'
  ze() { DIR=$(zoxide query -i "$@"); [ -n "$DIR" ] && cd "$DIR" && e .; }
fi

if command -v mise &> /dev/null; then
  eval "$(~/.local/bin/mise activate zsh)"
fi

if [ -d ~/perl5/lib/perl5/ ]; then
  eval $(perl -I ~/perl5/lib/perl5/ -Mlocal::lib)
fi

# ----- Starship (final; keep last) -----
# export STARSHIP_CONFIG="$HOME/.config/starship.toml"   # not needed if using default path
eval "$(starship init zsh)"

