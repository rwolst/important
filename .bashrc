# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

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

# Set the __git_ps1 function parameters which can be found in
#     /usr/lib/git-core/git-sh-prompt
GIT_PS1_SHOWUPSTREAM="auto"
GIT_PS1_SHOWDIRTYSTATE=1

if [ "$color_prompt" = yes ]; then
    # Display the git branch in prompt and add the directory size
    PS1="${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w \[\033[1;33m\]\$(/bin/ls -lah | /bin/grep -m 1 total | /bin/sed 's/total //')b\[\033[01;36m\]\$(__git_ps1)\[\033[00m\]\$ "

    # Display just the git branch in the prompt
    #PS1="${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[01;36m\]\$(__git_ps1)\[\033[00m\]\$ "

    # Default prompt
    # PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


# Add the chromedriver to the path
export PATH=$PATH:/usr/lib/chromium-browser/

# Ipython virtual environment
alias ipy="python3 -c 'import IPython; IPython.terminal.ipapp.launch_new_instance()'"

# Use Python3.6
alias python3="python3.6"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/rob/google-cloud-sdk/path.bash.inc' ]; then source '/home/rob/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/rob/google-cloud-sdk/completion.bash.inc' ]; then source '/home/rob/google-cloud-sdk/completion.bash.inc'; fi

# Open fuzzy checked file with vim
alias vimfzy="vim \$(find -type f | fzy)"
alias cdfzy="cd \$(find -type d | fzy)"

# Use vi keybindings.
set -o vi

# Add texlive binaries to path.
PATH=$HOME/.local/texlive/2018/bin/x86_64-linux:$PATH; export PATH
MANPATH=$HOME/.local/texlive/2018/texmf-dist/doc/man:$MANPATH; export MANPATH
INFOPATH=$HOME/.local/texlive/2018/texmf-dist/doc/info:$INFOPATH; export INFOPATH

# Create a function for sourcing a virtual environment.
act () {
    # Find any potnetial virtual environment.
    potential_envs=$(find . -regex '^\./.*env/bin/activate')
    total_envs=$(find . -regex '^\./.*env/bin/activate' | wc -w)

    # If there is only one possibility then source it, otherwise return a
    # warning.
    if [ $total_envs == 0 ]
    then
        echo "Found no potential virtual environments."
    elif [ $total_envs == 1 ]
    then
        echo "Sourcing virtual environment:"
        echo "$potential_envs"
        source $potential_envs
    else
        echo "Not sourcing, found multiple virtual environments:"
        echo "$potential_envs"
    fi
}

# Create virtual environment (awkward due to non pip).
# See here for explanation:
# http://thefourtheye.in/2014/12/30/Python-venv-problem-with-ensurepip-in-Ubuntu/
python3_venv () {
    # The name is in $1 and typically will be env.
    echo "Parameter #1 is $1"
    echo "Parameter length is $#"
    if [ $# == 0 ]
    then
        echo "Found no arguments to function, so using environment name 'env'."
        /usr/bin/python3.6 -m venv env --without-pip
        cd env
    else
        /usr/bin/python3.6 -m venv $1 --without-pip
        cd $1
    fi
    source bin/activate
    echo "Running in virtual environment: $VIRTUAL_ENV"
    wget https://bootstrap.pypa.io/get-pip.py

    # Can use the environment python3 from now on.
    python3 get-pip.py
    rm get-pip.py
    cd ..
}

