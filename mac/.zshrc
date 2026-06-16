# zsh plugins
source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

# aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# starship
eval "$(starship init zsh)"

# kitty startup
if [[ "$TERM" == "xterm-kitty" ]]; then
    printf "\033c"
    fastfetch
fi