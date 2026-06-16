# autosuggestions
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# syntax highlighting
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# starship
eval "$(starship init zsh)"

# aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# SSH only startup banner
if [[ -n "$SSH_CONNECTION" ]]; then
    printf "\033c"
    fastfetch
fi