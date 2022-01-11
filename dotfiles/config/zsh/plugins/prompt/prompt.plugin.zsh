#!/usr/bin/env zsh

# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats ' on %F{blue}branch (%b)%f'

function collapse_pwd {
    echo $(pwd | sed "s,^$HOME.*/,," | sed "s,^$HOME,~,")
}
# Set up the prompt (with git branch name)
setopt PROMPT_SUBST
PROMPT='%(?..%F{red}X %B%?%b%f )%(2L.[%B%F{red}%L%f%b] .)%B%F{yellow}%m%f%b %Bin $(collapse_pwd)%b%B${vcs_info_msg_0_}%b %(!.%Bas %F{red}root%f%b .)%F{cyan}->%f '
