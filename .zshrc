# Path to your oh-my-zsh installation.
export ZSH=/Users/jeradgallinger/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  fzf
  git
  ng
  node
  nvm
  osx
  ruby
  postgres
  tmux
  tmuxinator
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
alias mux="tmuxinator"
alias vim="nvim"
alias vi="nvim"
alias oldvim="\vim"

export TERM="tmux-256color"

bindkey "\eOH" beginning-of-line
bindkey "\eOF" end-of-line

# optionally set DEFAULT_USER in ~/.zshrc to your regular username to hide the “user@hostname” info when you’re logged in as yourself on your local machine.
export DEFAULT_USER=jeradgallinger
export USER=`whoami`

export PGDATA="/usr/local/var/postgres"

export UID=$(id -u ${whoami})
export GID=$(id -g ${whoami})

alias docker="env UID=$(id -u ${whoami}) GID=$(id -g ${whoami}) docker"
alias docker-compose="env UID=$(id -u ${whoami}) GID=$(id -g ${whoami}) docker-compose"

# Start pinata-ssh-forward daemon if it isn't already running
# (Inspired by https://stackoverflow.com/a/38576401)
if [ ! "$(docker ps -q -f name=pinata-sshd)" ]; then
  if [ "$(docker ps -aq -f status=exited -f name=pinata-sshd)" ]; then
    # cleanup
    echo "pinata-ssh-forward is stopped but has not been removed. Removing it before continuing.\n"
    docker rm pinata-sshd
  fi

  echo "Starting pinata-ssh-forward to forward ssh agent socket into docker containers.\n"

  sh pinata-ssh-forward

  if [ $? != "0" ]; then
    echo "ERROR: pinata-ssh-forward failed."
    echo "       Please run \"ssh-add -l\" to confirm that your ssh identity has been added."
    echo "       If it has not, run \"ssh-add\" and try running pinata-ssh-forward again."
  fi
fi

# Load NVM
# (Don't use the nvm oh-my-zsh plugin. Doesn't load nvm from brew on mac.)
export NVM_DIR="$HOME/.nvm"

. "$(brew --prefix nvm)/nvm.sh"  # This loads nvm on Mac with Homebrew

# added by travis gem
[ -f /Users/jeradgallinger/.travis/travis.sh ] && source /Users/jeradgallinger/.travis/travis.sh

# autojump
[ -f /usr/local/etc/profile.d/autojump.sh  ] && . /usr/local/etc/profile.d/autojump.sh

# start rbenv
export RBENV_ROOT=/usr/local/var/rbenv
eval "$(rbenv init -)"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
