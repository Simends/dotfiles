#   _____    ____  _          _ _ 
#  |__  /   / ___|| |__   ___| | |
#    / /____\___ \| '_ \ / _ \ | |
#   / /|_____|__) | | | |  __/ | |
#  /____|   |____/|_| |_|\___|_|_|

HISTFILE=~/.local/share/zsh/histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
unsetopt beep
bindkey -v
autoload -U colors && colors	# Load colors
stty stop undef		# Disable ctrl-s to freeze terminal

zstyle ':completion:*' completer _complete _ignored _correct _approximate
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:]}={[:upper:]}' ''
zstyle ':completion:*' menu select=1
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename '/home/simen/.zshrc'

autoload -Uz compinit
compinit

cdParentKey() {
  pushd ..
  zle      reset-prompt
  # print
  # ls
  # zle       reset-prompt
}

zle -N cdParentKey
bindkey '^[.' cdParentKey

# Load aliases
source $XDG_CONFIG_HOME/shell/aliases

# Load plugins
plugdir=$XDG_CONFIG_HOME/zsh/plugins
# source "$plugdir"/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
# source "$plugdir"/bgnotify/bgnotify.plugin.zsh
# source "$plugdir"/vi-mode/vi-mode.plugin.zsh
# source "$plugdir"/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/z/z.sh
source /usr/share/nnn/quitcd/quitcd.bash_zsh
source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source "$plugdir"/osc-7/osc-7.plugin.zsh
source "$plugdir"/prompt/prompt.plugin.zsh

# FZF
export FZF_ALT_C_OPTS="--layout=reverse --border=sharp --preview='ls --color=always -l {}'"
export FZF_CTRL_R_OPTS="--layout=reverse --border=sharp"
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
bindkey '^T' fzf-completion
bindkey '^I' $fzf_default_completion
