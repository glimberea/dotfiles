# start tmux session (only once!)
case $(tty) in
	*tty*) exec bash -l;;
esac

if [[ "$TERMINAL_EMULATOR" != "vscode" ]] && [[ "$TERMINAL_EMULATOR" != "JetBrains-JediTerm" ]] && [ -z "$TMUX" ] && [[ "$USER" == "glimberea" ]]; then
	ATTACH_OPT=$(tmux ls 2> /dev/null | grep -vq attached && echo "attach -d")
	exec eval "tmux $ATTACH_OPT"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME=""

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(history-substring-search zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

unset SSH_ASKPASS

# aliases
alias zshconfig="nano ~/.zshrc"
alias tmuxconfig="nano ~/.tmux.conf"
alias envconfig="nano ~/work/.envrc"
alias kube="kubectl"
alias kind-cloud-provider="cloud-provider-kind"
alias moss="~/Documents/Programming/moss.sh"
alias i="ionosctl"
alias isdk="ionossdk"
alias sdktr="csdk-test-runner"
alias tf="terraform"

export KUBE_EDITOR="nano"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

envpaths=()

export GOROOT=$HOME/.sdks/go1.24.5
envpaths+=("$GOROOT/bin")

export GOPATH=$HOME/go
envpaths+=("$GOPATH/bin")

export JAVA_HOME=$HOME/.jdks/openjdk-24.0.1
envpaths+=("$JAVA_HOME/bin")

export PATH=$( IFS=":"; echo "${envpaths[*]}" ):$PATH
export PATH=${KREW_ROOT:-$HOME/.krew}/bin:$PATH
export PATH=${TEX_PATH:-/usr/local/texlive/2025/bin/x86_64-linux}:$PATH

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
eval "$(direnv hook zsh)"

source <(kubectl completion zsh)
complete -o default -F __start_kubectl kube

source <(helm completion zsh)
source <(kind completion zsh)
source <(crossplane completions)

eval $(codex autocomplete:script zsh)
source <(ionosctl completion zsh)

fpath+=($HOME/.config/ionosctl/completion/zsh)
autoload -Uz compinit; compinit

autoload -U +X bashcompinit && bashcompinit

complete -o nospace -C /usr/bin/terraform terraform
complete -o nospace -C /home/linuxbrew/.linuxbrew/Cellar/opentofu/1.10.5/bin/tofu tofu

# Pure Theme
#fpath+=("$(brew --prefix)/share/zsh/site-functions")
#autoload -U promptinit; promptinit
#prompt pure

# Starship Theme
eval "$(starship init zsh)"
