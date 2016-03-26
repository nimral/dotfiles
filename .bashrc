# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

#Make Bash append rather than overwrite the history on disk:
shopt -s histappend

#Whenever displaying the prompt, write the previous line to disk:
PROMPT_COMMAND='history -a'

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
#if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
#    debian_chroot=$(cat /etc/debian_chroot)
#fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

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

PROMPT_COLOR='7;32m';

# If I am root, set the prompt to bright red
if [ ${UID} -eq 0 ]; then
    PROMPT_COLOR='0;31m31'
fi

if type __git_ps1 1>/dev/null ; then
    # show git branch and state in prompt. Requires __git_ps1
    # example: matej@arthur ~/bin/dotfiles(master #) $
    export GIT_PS1_SHOWDIRTYSTATE=1
    PS1='\[\e[0;32m\]\u@\h \[\e[1;34m\]\w\[\e[0;37m\]$(__git_ps1 "(%s)") \[\e[0;32m\]\$\[\e[0;37m\] '
else
    PS1='\[\e[0;32m\]\u@\h \[\e[1;34m\]\w \[\e[0;32m\]\$ \[\e[0;37m\] '
fi

unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ] && [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto --group-directories-first'
fi

export GREP_COLOR="1;33"


if [ "$DISPLAY" ] ; then
    EDITOR=gvim
else
    EDITOR=vim
fi
alias e="$EDITOR"
alias E="sudo $EDITOR"


alias grep='grep --color=auto'

# some more ls aliases
alias ls='ls --color=auto --group-directories-first'
alias ll='ls -lh --color=auto --group-directories-first'
alias la='ls -Al'

alias lsd='ls -d */'

# some apt aliases
ainstall () {
    sudo apt-get install $@ || apt-cache search "$1"
}
aremove () {
    sudo apt-get remove $@
    sudo apt-get autoremove
}
alias asearch='apt-cache search'
alias aupdate='sudo apt-get update'
alias aupgrade='sudo apt-get upgrade'

alias fpcexe='wine "C:\\FPC\2.2.2\bin\i386-win32\fpc.exe"'
alias lazexe='wine "C:\\lazarus\lazbuild.exe"'
alias sens="sensors | grep crit |  sed -r 's/[^ ]+\ +([^ ]+).*/\1/'"
alias exiftool='~/bin/Image-ExifTool-8.61/exiftool'
alias g='git'
alias gplusplus='g++ -std=c++11 -g -O0 -Wall -pedantic -pthread'
alias dus='du | sort -n'
alias bc='bc -q -l'
alias fef='feh --magick-timeout "-1" --force-aliasing -F 2> /dev/null -A "cp %f ~/Obrázky/vyber" --action1 "gimp %f &" --action2 "mv %f \`cat\`" --action9 "feh --bg-fill `pwd`/%F" --action3 "echo %f"'
alias feh='feh --magick-timeout "-1"'
alias oowriter='libreoffice --writer'
alias ooimpress='libreoffice --impress'
alias oocalc='libreoffice --spreadsheet'
alias prename='perl-rename'
alias okular='okular 2> /dev/null'
alias py='python'
alias py27='python2.7'
alias ipy='ipython'
alias ftp='ftp -i'
alias todo='cat ~/todo'
alias etodo='e ~/todo'
alias tw='translate.py'
alias git-zmenene="git log --name-only --pretty=oneline --full-index HEAD^^..HEAD | grep -vE '^[0-9a-f]{40} ' | sort | uniq"
alias preloz='python3 ~/bin/python/slovnik.py'
alias slovnik='python3 ~/bin/python/slovnik.py'
alias cal='ncal -M3'
alias briss='java -jar ~/bin/briss-0.9/briss-0.9.jar'
alias octave='octave --no-gui'
alias pocasi='curl -4 http://wttr.in'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
# enable git completion with alias g="git"
if [ -f ~/bin/git-completion.bash ]; then
    . ~/bin/git-completion.bash
    __git_complete g __git_main
fi

export PATH=$PATH:$HOME/bin

#turn off ctrl-s
stty -ixon

umask 077
