alias lsa="ls -al"
alias lsr="ls -alR"
alias edit-zconfig="vim ~/dotfiles/zsh/zshrc_custom.sh"
update-dotfiles() {

	git checkout master
	git pull # it pulls from upstream!
	git checkout custom
	git rebase master # safe if you are alone working on that branch
	git push --force # ditto. It pushes to origin, which is your fork.
}



