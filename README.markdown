install on another machine
--------------------------

	git clone http://github.com/byteclub/dotvim.git ~/.vim
	ln -s ~/.vim/vimrc ~/.vimrc
	ln -s ~/.vim/gvimrc ~/.gvimrc
	cd ~/.vim
	git submodule init
	git submodule update

Generate help for all plugins (using a command provided by pathogen)

  :Helptags


update and pull all submodules
------------------------------

	$ git submodule foreach git checkout master
	$ git submodule foreach git pull

	commit update

	$ git commit -a -m "update submodules" 


add a new submodule
-------------------

	$ cd ~/.vim
	$ git submodule add <github-url> bundle/<local-folder-for-plugin>
