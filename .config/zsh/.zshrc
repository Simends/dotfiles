# Zoomer shell

HISTFILE=~/.local/share/zsh/histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
unsetopt beep
bindkey -v
autoload -U colors && colors	# Load colors
stty stop undef		# Disable ctrl-s to freeze terminal

#zstyle ':completion:*' completer _complete _ignored _correct _approximate
#zstyle ':completion:*' list-colors ''
#zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:]}={[:upper:]}' ''
#zstyle ':completion:*' menu select=1
#zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
#zstyle :compinstall filename '/home/simen/.zshrc'

#autoload -Uz compinit
#compinit

# Set prompt
PROMPT="%B%F{cyan}%~%b%B >>>%f%b "

# Load aliases and env variables
source $HOME/.config/shell/aliases
source $HOME/.config/shell/profile

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.


# Load plugins
plugdir=$HOME/.config/zsh/plugins
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
source "$plugdir"/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source "$plugdir"/zsh-autosuggestions/zsh-autosuggestions.zsh
source "$plugdir"/zsh-interactive-cd/zsh-interactive-cd.plugin.zsh

# Run at startup
pfetch
