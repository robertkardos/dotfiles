alias ll="ls -Galph"
alias la='ls -CAF'
alias l='ls -CF'

alias cs="cd"

alias _-restart="sudo shutdown -r now"
alias _-shutdown="sudo shutdown -h now"
alias _-suspend="systemctl suspend"

alias _-sauce="source ~/.bashrc"
alias _-aliases="nano ~/.bash_aliases"

alias _-gg='git grep -n $@'
alias _-ta="tmux a"


alias userinstalled="comm -23 <(apt-mark showmanual | sort -u) <(gzip -dc /var/log/installer/initial-status.gz | sed -n 's/^Package: //p' | sort -u)"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

