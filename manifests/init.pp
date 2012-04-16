#TODO init submodules after checkout
class dotvim {
	define vim($git_repo="git://github.com/heim/dotvim.git") {

		Package["git-core"] -> Exec["clone-vim-files-for-$name"] -> File["/home/$name/.vimrc"]

    if(!defined(Package["git-core"])) {
      package { "git-core":
        ensure => present,
      }
    }

		exec { "clone-vim-files-for-$name":
			path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin",
			     user => "$name",
			     cwd => "/home/$name",
			     command => "git clone $git_repo .vim",
			     creates => "/home/$name/.vim/.git",
		}



		file { "/home/$name/.vimrc":
			ensure => link,
			       target => "/home/$name/.vim/vimrc",
			       owner => "$name",
		}

		exec { "update-vim-files-for-$name":
			path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/bin",
			     user => "$name", 
			     cwd => "/home/$name/.vim",
			     command => "git pull origin master",
			     require => Exec["clone-vim-files-for-$name"],
		}

	}
}
