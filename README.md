# BRIEF #
This plugin enhances the reading and writing of files encrypted using
Vim's built in Blowfish encryption and sets up some recommended
settings for reading/editing encrypted files.


# DESCRIPTION #
This plugin's main purpose is to enhance the built in
encryption of Vim for encrypted files.

Since vim 7.3 the option to use the Blowfish encryption is
possible (you can simply set cm=blowfish in your .vimrc but
you also need to disable swapfiles, backup files, and
viminfo).

Since I would also like the option to hide (not have visable)
as much as I can while editing encrypted files, a method to
hide areas in folds is also desirable.

In addition, I would also like vim to close if and when I get
up to go get coffee.

This plugin loads when a file with file name with the syntax of: 
      `<filename>.auth`
      or
      `<Filename>.auth.<Extension>`
              _(this allows you to use this plugin with other plugins like VimWiki)_

### How do I get set up? ###
If you don't have a preferred installation method, I recommend installing [pathogen.vim](https://github.com/tpope/vim-pathogen), and then simply copy and paste:

    cd ~/.vim/bundle
    git clone https://github.com/JohnKaul/vimcryptsafe.vim.git

Otherwise you can always download this and place the `vimcryptsafe.vim` file in the `plugin` directory. 

### Contribution guidelines ###
* Contribute? Please. Feel free.
* Code review? Yes, please.
* Comments? Yes, please.

### Git Standards ###
Each commit will be structured like this:
`"vimcryptsafe.vim: Formatting cleanup."`
Where the file name is listed first followed by a colon and a brief description of the change.

### Coding Standards ###
1. Each file should contain the line: `" File Last Updated: ` followed by the date. I use a simple vim mapping for this.

### Who do I talk to? ###
* John Kaul - john.kaul@outlook.com
