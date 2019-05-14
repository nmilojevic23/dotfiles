#
# ~/.bashrc
#
[[ $- != *i* ]] && return
set -o vi

alias ls='ls --color=auto'
alias vim='nvim'
alias la='ls -lah --color=auto'
alias watchpdf='latexmk -pdf -pvc'

reflow() {
    DIR=$(basename $(pwd))
    mkdir -p ~/Dropbox/reflow/$DIR
    k2pdfopt $* -dpi 267 -w 1536 -h 2048 -wrap -hy -om 0.3 -o ~/Dropbox/reflow/$DIR/$*
}

launch_polybar() {
	killall -q polybar
	while pgrep -x polybar >/dev/null; do sleep 1; done
	for i in $(polybar -m | awk -F: '{print $1}'); do
		MONITOR=$i polybar example -c ~/.config/polybar/config &
	done
}

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"


PS1='[\u@\h \W]\$ '
PS1=' \[\e[31m\]\W ❱\[\e[32m\]❱\[\e[33m\]❱ \[\e(B\e[m\]'
export EDITOR="vim"
export TERM=screen-256color
export NCARG_ROOT="/opt/ncl"
export PETSC_DIR="/opt/petsc"
export PETSC_ARCH="linux-c-opt"

export PATH="$HOME/.local/bin:$PATH:$HOME/.gem/ruby/2.4.0/bin"
export PATH="$HOME/.scripts:$HOME/perl5/bin${PATH:+:${PATH}}"

export PERL5LIB="/home/bzq/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"
export PERL_LOCAL_LIB_ROOT="/home/bzq/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"
export PERL_MB_OPT="--install_base \"/home/bzq/perl5\""
export PERL_MM_OPT="INSTALL_BASE=/home/bzq/perl5"

# --------------------------
# Machine specific rc files
# --------------------------
if [ -f "$HOME/.hyakrc" ]; then
	source $HOME/.hyakrc
fi

if [ -f "$HOME/.h2orc" ]; then
	source $HOME/.h2orc
fi

if [ -f "$HOME/.cheyennerc" ]; then
	source $HOME/.cheyennerc
fi

echo $BASE16_THEME > ~/.config/base16-shell/current_theme
