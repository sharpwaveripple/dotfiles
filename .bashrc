# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Prepend cd to directory names automatically
shopt -s autocd 2> /dev/null    # Auto cd if no cd provided
shopt -s cdspell 2> /dev/null   # Correct spelling on cd
shopt -s checkwinsize           # Resizes commands if window changes
shopt -s cmdhist                # Saves multi-line commands to one line
shopt -s dirspell 2> /dev/null  # Spell check on tab complete
shopt -s globstar               # Use ** to match all files in path expansion
shopt -s histappend             # Save history after session ends

HISTCONTROL=ignoreboth          # Ignore duplicate lines
HISTSIZE=500000
HISTFILESIZE=100000
HISTIGNORE="&:[ ]*:exit:ls:cd:bg:fg:history:clear" # Don't save these commands
PROMPT_DIRTRIM=2 # Trim long paths
PROMPT_COMMAND='history -a' # Record each line as it gets issued

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes
if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
# export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
# alias l='ls -CF'
alias dc='cd'
alias sl='ls'
alias sl=ls
alias ks=ls
alias js=ls
alias gf=fg
alias dc=cd
alias emcas=emacs
alias emasc=emacs

# Prevent file overwrite on stdout redirection
# Use `>|` to force redirection to an existing file
# Warning: doesn't play nicely with bashmarks
# set -o noclobber

# Enable incremental history search with up/down arrows (also Readline goodness)
# Learn more about this here: http://codeinthehole.com/writing/the-most-important-command-line-tip-incremental-history-searching-with-inputrc/
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\e[C": forward-char'
bind '"\e[D": backward-char'

bind Space:magic-space # Typing !!<space> will replace the !! with your last command

# Immediately add a trailing slash when autocompleting symlinks to directories
bind "set mark-symlinked-directories on"
bind "set bell-style none"

alias R='$(/usr/bin/which R) --no-save'
export R_LIBS_USER="${HOME}/.lib/R/4.0"
source ~/.commacd.sh

up() { for dir in $(seq 1 $1); do cd ..; done ; }

compress() {
    in="${1%/}"
    ar="${1%/}.txz"
    printf "Compressing %s to %s... " "$in" "$ar"
    tar cf "${1%/}.txz" "${1%/}"
    printf "done\n"
    printf "Checking for %s/desktop... " "$HOME"
    if [[ -d "$HOME/desktop/" ]]; then
        printf "exists\n"
        printf "Moving %s to $HOME/desktop/... " "$ar"
        mv "$ar" "$HOME/desktop/"
        printf "done\n"
    else
        printf "no\n"
    fi
}

extract() {
    if [ -f "$1" ] ; then
        printf "Extracting %s... " "$1"
        case "$1" in
            *.tar.bz2)   tar xjf "$1"    ;;
            *.tar.gz)    tar xzf "$1"    ;;
            *.tar.xz)    tar xf "$1"     ;;
            *.bz2)       bunzip2 "$1"     ;;
            *.rar)       unrar x "$1"     ;;
            *.gz)        gunzip "$1"      ;;
            *.tar)       tar xf "$1"     ;;
            *.tbz2)      tar xjf "$1"    ;;
            *.tgz)       tar xzf "$1"    ;;
            *.txz)       tar xf "$1"     ;;
            *.zip)       unzip "$1"       ;;
            *.Z)         uncompress "$1"  ;;
            *.7z)        7z x "$1"        ;;
            *)           echo "don't know how to extract '$1'..." ;;
        esac
        printf "done\n"
        printf "Removing archive... "
        rm "$1"
        printf "done\n"
    else
        echo "$1 is not a valid file!"
    fi
}


update() { sudo apt update && sudo apt -y upgrade && sudo apt -y autoremove; }

export DISPLAY=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null):0
export LIBGL_ALWAYS_INDIRECT=1
# export DISPLAY=:0

export PATH="${HOME}/bin:$PATH"
export PATH="${HOME}/bin/utils:$PATH"
export PATH="${HOME}/.anaconda3/bin:$PATH"
export PATH="${HOME}/bin/matlab/bin:$PATH"
export PATH="${HOME}/.emacs.d/bin:$PATH"

# https://nickymeuleman.netlify.app/blog/gui-on-wsl2-cypress#the-display-variable
sudo /etc/init.d/dbus start &> /dev/null

# https://www.cyberciti.biz/faq/bash-check-if-process-is-running-or-notonlinuxunix/
if ! pgrep -x emacs >/dev/null; then emacs &>/dev/null & fi
if ! pgrep -x pcloud >/dev/null; then ${HOME}/bin/pcloud &>/dev/null & fi
