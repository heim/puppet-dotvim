.h1 Puppet module for managing vim-files

Example usage:
  
  
  vim { "username":
    git_repo => "git://github.com/heim/dotvim.git",
  }



Git repo must contain a vimrc-file. See my dotvim-repo for an example.
Tested on ubuntu, but should work on all supported platforms.


License: Do whatever you want.
