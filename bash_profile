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

# Flush the DNS cache
alias flush="sudo discoveryutil mdnsflushcache ; sudo discoveryutil udnsflushcaches ; sudo launchctl stop homebrew.mxcl.dnsmasq ; sudo launchctl start homebrew.mxcl.dnsmasq"

alias git="hub"
alias json="python -m json.tool"
docker-clean() { docker rm --volumes=true $(docker ps -a -q); docker rmi --force $(docker images -a --no-trunc | grep "^<none>" | awk '{print $3}'); }

export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=$PATH:/Users/delois/.composer/vendor/bin
# export PATH=$PATH:$HOME/.cabal/bin

# Homebrew PHP onto the CLi
export PATH="$(brew --prefix homebrew/php/php71)/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

# Go
export GOPATH=/Users/delois/Development/go
export PATH=$PATH:$GOPATH/bin

# PHPUnit
export CVG_DIR="/Users/delois/Desktop/cvg-html";

if which docker-machine > /dev/null; then
  export DOCKER_TLS_VERIFY="1"
  export DOCKER_HOST="tcp://172.16.159.128:2376"
  export DOCKER_CERT_PATH="/Users/delois/.docker/machine/machines/dev"
  export DOCKER_MACHINE_NAME="local"
fi

# Secret tokens, etc.
source ~/.bash_secrets

# Blackfire (Variables defined in secrets.sh)

alias blackfire="docker run -it --rm -e BLACKFIRE_CLIENT_ID=$BLACKFIRE_CLIENT_ID -e BLACKFIRE_CLIENT_TOKEN=$BLACKFIRE_CLIENT_TOKEN blackfire/blackfire blackfire "
alias blackfire-query="blackfire run sh -c 'echo \$BLACKFIRE_QUERY'"
