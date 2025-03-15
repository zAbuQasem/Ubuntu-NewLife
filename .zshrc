# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
unsetopt autocd
# Path to your oh-my-zsh installation.
export ZSH="/home/${USER}/.oh-my-zsh"
export PAGER="most"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="robbyrussell"
#ZSH_THEME="miloshadzic"
#ZSH_THEME="gnzh"
#ZSH_THEME="jnrowe"
#ZSH_THEME="af-magic"
#ZSH_THEME="miloshadzic"
ZSH_THEME="powerlevel10k/powerlevel10k"
#
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
 zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
 DISABLE_AUTO_TITLE="true"

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
plugins=(git kube-ps1 tmux fzf ssh-agent zsh-syntax-highlighting zsh-autosuggestions web-search)

source $ZSH/oh-my-zsh.sh

#source $ZSH_CUSTOM/plugins/fzf-tab-completion/zsh/fzf-zsh-completion.sh
#FZF_COMPLETION_AUTO_COMMON_PREFIX_PART=true
bindkey '^I' fzf_completion

RPROMPT='$(kube_ps1)'

# zsh-syntax-highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
ZSH_HIGHLIGHT_STYLES[default]=none
ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=red,bold
ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=cyan,bold
ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=green,underline
ZSH_HIGHLIGHT_STYLES[global-alias]=fg=magenta
ZSH_HIGHLIGHT_STYLES[precommand]=fg=green,underline
ZSH_HIGHLIGHT_STYLES[commandseparator]=fg=blue,bold
ZSH_HIGHLIGHT_STYLES[autodirectory]=fg=green,underline
ZSH_HIGHLIGHT_STYLES[path]=underline
ZSH_HIGHLIGHT_STYLES[path_pathseparator]=
ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]=
ZSH_HIGHLIGHT_STYLES[globbing]=fg=blue,bold
ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=blue,bold
ZSH_HIGHLIGHT_STYLES[command-substitution]=none
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]=fg=magenta
ZSH_HIGHLIGHT_STYLES[process-substitution]=none
ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]=fg=magenta
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=magenta
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=magenta
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]=fg=blue,bold
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=yellow
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=yellow
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]=fg=yellow
ZSH_HIGHLIGHT_STYLES[rc-quote]=fg=magenta
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=magenta
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=magenta
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]=fg=magenta
ZSH_HIGHLIGHT_STYLES[assign]=none
ZSH_HIGHLIGHT_STYLES[redirection]=fg=blue,bold
ZSH_HIGHLIGHT_STYLES[comment]=fg=black,bold
ZSH_HIGHLIGHT_STYLES[named-fd]=none
ZSH_HIGHLIGHT_STYLES[numeric-fd]=none
ZSH_HIGHLIGHT_STYLES[arg0]=fg=green
ZSH_HIGHLIGHT_STYLES[bracket-error]=fg=red,bold
ZSH_HIGHLIGHT_STYLES[bracket-level-1]=fg=blue,bold
ZSH_HIGHLIGHT_STYLES[bracket-level-2]=fg=green,bold
ZSH_HIGHLIGHT_STYLES[bracket-level-3]=fg=magenta,bold
ZSH_HIGHLIGHT_STYLES[bracket-level-4]=fg=yellow,bold
ZSH_HIGHLIGHT_STYLES[bracket-level-5]=fg=cyan,bold
ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]=standout

# zsh-autosuggestions
#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=244"  # choose when using 256-color theme
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#999999"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
#fzcode() { print -z `cat ~/.fzcode/{posts,ppn} | fzf --tac --cycle --height=~50% --color=16` }
SharpCollection() { print -z `curl -sSL "https://api.github.com/repos/Flangvik/SharpCollection/git/trees/master?recursive=1" | jq -r ".tree[].path" | grep \\.exe | while read line; do echo "curl -sSL https://github.com/Flangvik/SharpCollection/raw/master/$line -o"; done | fzf --tac --cycle --height=~50% --color=16` }
Feroxbuster-w() { print -z `([ -d /usr/share/seclists ] && find /usr/share/seclists/Discovery/Web-Content -maxdepth 1 -type f || find /usr/share/wordlists/dirbuster/ -maxdepth 1 -type f) | sort | while read line; do echo "feroxbuster -w $line -A -k -r -t 15 -n -u"; done | fzf --tac --cycle --height=~50% --color=16` }
Ffuf-w() { print -z `([ -d /usr/share/seclists ] && find /usr/share/seclists/Discovery/Web-Content -maxdepth 1 -type f || find /usr/share/wordlists/dirbuster/ -maxdepth 1 -type f) | sort | while read line; do echo "ffuf -w $line -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36' -ic -sf -r -c -t 15 -mc all -u"; done | fzf --tac --cycle --height=~50% --color=16` }
Httpx-p() { print -z `(echo 'httpx -sc -fr -location -title -server -td -method -ip -cname -cdn -p "80,81,443,1080,3000,3128,7001,7002,8080,8443,8888" -t 15 -l'; echo 'httpx -sc -fr -location -title -server -td -method -ip -cname -cdn -t 15 -l') | fzf --tac --cycle --height=~50% --color=16` }

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

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

export PATH="${PATH}:${HOME}/.local/bin/"
export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin:$HOME/.local/bin:$PATH:/snap/bin:$HOME/.cargo/env:$HOME/.cargo/bin/
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# General aliases
alias vim='/usr/bin/nvim'
alias ؤمثشق='clear'
alias c="xclip -sel clip"
alias cat='batcat'
alias gip="grep -oE '\b([0-9]{1,3}\.){3}[0-9]{1,3}\b'"

# Git aliases
alias pullall='for dir in */; do if [ -d "$dir/.git" ]; then echo -e "\e[32m[+] Pulling $dir\e[0m" && (cd "$dir" && git pull) ; echo ; fi; done'
#alias pullall="ls | xargs -P10 -I{} echo \"[+] Pulling {}\" && git -C {} pull"

# Kubernetes aliases
source <(kubectl completion zsh)
source <(helm completion zsh)
compdef kubecolor=kubectl
alias k="kubecolor"
alias ktx="kubectl config use-context"
alias svc-ports="kubectl get svc -A | awk -F' ' '{print \$6}' | grep ':' | tr \",\" \"\n\""
alias argocd-creds='kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d | c '
alias argocd-expose="kubectl port-forward service/argo-cd-argocd-server -n argocd 8080:443 -n argocd"

# Terraform and Packer aliases
alias tfmt='terraform fmt -recursive -check'
alias pfmt='echo "Formatting with packer fmt -recursive=true ."; packer fmt -recursive=true .'

# Docker aliases
alias dc-chal='docker compose --profile chal up --build'
alias dc-dist='docker compose --profile dist up --build'
alias dc-clean='docker system prune -f'
alias dc-logs='docker compose logs -f'

# Miscellaneous aliases
alias flush-dns="sudo resolvectl flush-caches ; sudo resolvectl statistics"
alias new-server="curl -sS https://gist.githubusercontent.com/zAbuQasem/cbdc151a15277a96117b34b6c56934d9/raw/21b17e5b0f0b2e7baae0165859f67db114a738db/terminal.sh |c"
alias g="google examtopics exam google associate cloud engineer question $1"



# Function to quickly check if a TCP port is open on a given host.
# Usage: quick-ping <host>:<port>
# Example: quick-ping google.com:80
quick-ping (){ DST="$@"; timeout 1 bash -c "echo > /dev/tcp/$DST &>/dev/null" &>/dev/null && echo '[+] Open' || echo '[!] Closed'  }

# Function to print the command used by quick-ping for debugging purposes.
# Usage: quick-ping-p <host>:<port>
# Example: quick-ping-p google.com:80
quick-ping-p (){ DST="$@"; echo "timeout 1 bash -c 'echo > /dev/tcp/$DST &>/dev/null' &>/dev/null && echo '[+] Open' || echo '[!] Closed'"  }

# Function to get help on a command using tgpt.
# Usage: howto <command>
# Example: howto ls
howto (){ CMD="$@"; /usr/local/bin/tgpt "$CMD" }

# Function to add, commit, pull, and show the latest commit in a git repository.
# Usage: pullpush <commit_message>
# Example: pullpush "Initial commit"
pullpush (){ CommitMSG="$@"; git add . ; git commit -m "$CommitMSG"; git pull ;git show }

# Function to encode a string or stdin to base64.
# Usage: b64 <string> or echo <string> | b64
# Example: b64 "hello"
b64() { [ -p /dev/stdin ] && base64 -w0 || echo -n "$@" | base64 -w0; }

# Function to decode a base64 string or stdin.
# Usage: b64d <base64_string> or echo <base64_string> | b64d
# Example: b64d "aGVsbG8="
b64d() { [ -p /dev/stdin ] && base64 -d -w0 || echo -n "$@" | base64 -d -w0; }

# Function to get the size of a Docker image.
# Usage: dockersize <image_name>
# Example: dockersize ubuntu:latest
dockersize() { docker manifest inspect -v "$1" | jq -c 'if type == "array" then .[] else . end' |  jq -r '[ ( .Descriptor.platform | [ .os, .architecture, .variant, ."os.version" ] | del(..|nulls) | join("/") ), ( [ .SchemaV2Manifest.layers[].size ] | add ) ] | join(" ")' | numfmt --to iec --format '%.2f' --field 2 | column -t ; }


SSHCONFIG (){
  if [[ $# -lt 2 ]]; then
    echo -e "\e[31m[Error]: Not enough arguments!\e[0m"
    echo -e "\e[31mUsage: SSHCONFIG [-i identity_file] [-P port] user@host alias\e[0m"
    echo -e "\e[31m[!] Position Matters!\e[0m"
    return 1
  fi

  local OPTIND
  local SSH_OPTIONS
  local SSH_ARGS
  local HOST
  local ALIAS
  local PRIVATE_KEY
  local CONF_PORT
  local PORT

  while getopts "i:p:" opt; do
    case ${opt} in
      i )
        PRIVATE_KEY=${OPTARG}
        ;;
      p )
        CONF_PORT=${OPTARG}
        ;;
      \? )
        echo -e "\e[31m[Error]: Invalid option!\e[0m"
        echo -e "\e[31mUsage: SSHCONFIG [-i identity_file] [-P port] user@host alias\e[0m"
        echo -e "\e[31m[!] Position Matters!\e[0m"
        return 1
        ;;
    esac
  done
  shift $((OPTIND -1))

  SSH_ARGS=$1
  HOST=$(echo $1 | cut -d '@' -f 2)
  ALIAS=$2
  PORT="${CONF_PORT:-22}"

  if [[ -n "$PRIVATE_KEY" ]]; then
    cat <<EOF >> "/home/${USER}/.ssh/config"

Host $ALIAS
  HostName ${HOST} 
  User ${SSH_ARGS%@*}
  Port ${PORT}
  IdentityFile ${PRIVATE_KEY}
EOF
    echo -e "\e[32m[Success]: SSH configuration added for $ALIAS\e[0m"
  else
    cat <<EOF >> "/home/${USER}/.ssh/config"

Host $ALIAS
  HostName ${HOST} 
  User ${SSH_ARGS%@*}
  Port ${PORT}
EOF
    echo -e "\e[32m[Success]: SSH configuration added for $ALIAS\e[0m"
  fi
}


new_chall(){
	local RED='\033[0;31m'
  local NC='\033[0m'
	if [ "$#" -ne "0" ];
	then
		mkdir -p "$1"/{chal,writeup}
    touch "$1"/summary.toml
    cp ~/metactf-challenges/docker-compose.yaml "$1"
    cd "$1"
	else
		echo -e "${RED}[!] Usage: $0 <CHALL-NAME> ${NC}"
	fi
}

ctf_init(){
	local RED='\033[0;31m'
  local NC='\033[0m'
	if [ "$#" -ne "0" ];
	then
		mkdir -p "$1"/{web,forensics,reverse,pwn,misc}
    cd "$1/web"
	else
		echo -e "${RED}[!] Usage: $0 <CTF-NAME> ${NC}"
	fi
}

# pwninit (auto patch binarieera)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
function rtfm() { ~/tools/rtfm/rtfm.py "$@" 2>/dev/null }
source <(argocd completion zsh)
source <(helm completion zsh)

fpath=(/home/${USER}/.oh-my-zsh/custom/completions /home/${USER}/.oh-my-zsh/custom/plugins/zsh-autosuggestions /home/${USER}/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting /home/${USER}/.oh-my-zsh/plugins/ssh-agent /home/${USER}/.oh-my-zsh/plugins/fzf /home/${USER}/.oh-my-zsh/plugins/tmux /home/${USER}/.oh-my-zsh/plugins/command-not-found /home/${USER}/.oh-my-zsh/plugins/git /home/${USER}/.oh-my-zsh/functions /home/${USER}/.oh-my-zsh/completions /home/${USER}/.oh-my-zsh/cache/completions /usr/local/share/zsh/site-functions /usr/share/zsh/vendor-functions /usr/share/zsh/vendor-completions /usr/share/zsh/functions/Calendar /usr/share/zsh/functions/Chpwd /usr/share/zsh/functions/Completion /usr/share/zsh/functions/Completion/AIX /usr/share/zsh/functions/Completion/BSD /usr/share/zsh/functions/Completion/Base /usr/share/zsh/functions/Completion/Cygwin /usr/share/zsh/functions/Completion/Darwin /usr/share/zsh/functions/Completion/Debian /usr/share/zsh/functions/Completion/Linux /usr/share/zsh/functions/Completion/Mandriva /usr/share/zsh/functions/Completion/Redhat /usr/share/zsh/functions/Completion/Solaris /usr/share/zsh/functions/Completion/Unix /usr/share/zsh/functions/Completion/X /usr/share/zsh/functions/Completion/Zsh /usr/share/zsh/functions/Completion/openSUSE /usr/share/zsh/functions/Exceptions /usr/share/zsh/functions/MIME /usr/share/zsh/functions/Math /usr/share/zsh/functions/Misc /usr/share/zsh/functions/Newuser /usr/share/zsh/functions/Prompts /usr/share/zsh/functions/TCP /usr/share/zsh/functions/VCS_Info /usr/share/zsh/functions/VCS_Info/Backends /usr/share/zsh/functions/Zftp /usr/share/zsh/functions/Zle)

export PATH=/home/${USER}/bin:$PATH

[[ -e "/home/${USER}/lib/oracle-cli/lib/python3.10/site-packages/oci_cli/bin/oci_autocomplete.sh" ]] && source "/home/${USER}/lib/oracle-cli/lib/python3.10/site-packages/oci_cli/bin/oci_autocomplete.sh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
