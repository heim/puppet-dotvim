class vim {
  
  Package["git-core"] -> Exec["clone-vim-files"] -> Exec["update-vim-files"] -> File["/home/vagrant/.vimrc"]

  package { "git-core":
    ensure => present,
  }

  exec { "clone-vim-files":
    path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin",
    user => "vagrant",
    cwd => "/home/vagrant",
    command => "git clone git://github.com/heim/dotvim.git .vim",
    creates => "/home/vagrant/.vim",
  }

  exec { "update-vim-files":
    path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin",
    user => "vagrant", 
    cwd => "/home/vagrant/.vim",
    command => "git pull origin master",
  }

  file { "/home/vagrant/.vimrc":
    ensure => link,
    target => "/home/vagrant/.vim/vimrc",
    owner => "vagrant",
  }


}
