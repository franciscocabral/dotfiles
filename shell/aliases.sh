alias please='sudo'
alias zshconfig="code ~/.zshrc"
alias ohmyzsh="code ~/.oh-my-zsh"

for al in `git config --list | grep -oE 'alias\.\w+' | sed 's/alias\.//'`; do
  alias g$al="git $al"
done

