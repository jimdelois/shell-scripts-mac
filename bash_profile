# Get XDebug going for any CLI requests
export XDEBUG_CONFIG="idekey=idekey-xdebug"

# Git Bash Auto Completion
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# Git: Prompt formatted to include Git information
source ~/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=
GIT_PS1_SHOWUNTRACKEDFILES=
PS1='[\[\033[36m\]\u \[\033[33m\]\W\[\033[31m\]$(__git_ps1 " %s")\[\033[0m\]]\$ '

alias menagerie="cd /Users/delois/Development/Projects/Managed"

# Flush the DNS cache
alias flush="sudo killall -HUP mDNSResponder;sudo killall mDNSResponderHelper;sudo dscacheutil -flushcache"

alias git="hub"
alias json="python -m json.tool"
docker-clean() { docker rm --volumes=true $(docker ps -a -q); docker rmi --force $(docker images -a --no-trunc | grep "^<none>" | awk '{print $3}'); }

export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=$PATH:/Users/delois/.composer/vendor/bin
# export PATH=$PATH:$HOME/.cabal/bin


export PATH="/usr/local/sbin:$PATH"

# Go
export GOPATH=/Users/delois/Development/go
export PATH=$PATH:$GOPATH/bin

# PHPUnit
export CVG_DIR="/Users/delois/Desktop/cvg-html";


# For "Too Many Open Files"
ulimit -n 10240

# Secret tokens, etc.
source ~/.bash_secrets

# Blackfire (Variables defined in secrets.sh)

alias blackfire="docker run -it --rm -e BLACKFIRE_CLIENT_ID=$BLACKFIRE_CLIENT_ID -e BLACKFIRE_CLIENT_TOKEN=$BLACKFIRE_CLIENT_TOKEN blackfire/blackfire blackfire "
alias blackfire-query="blackfire run sh -c 'echo \$BLACKFIRE_QUERY'"


test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
