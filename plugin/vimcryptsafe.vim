" vimcryptpasswordsafe.vim 
"
" Version:              0.2
" Author:               John Kaul
" Email:                john.kaul@outlook.com
" File Last Updated:    08.21.15 8:24:30 AM
"
" BIREF
"       This plugin enhances the reading and writing of files
"       encrypted using Vim's builtin Blowfish encryption and sets up
"       some recommended settings for reading/editing encrypted files.

" DESCRIPTION
"       This plugin's main purpose is to enhance the built in
"       encryption of Vim for encrypted files.
"
"       Since vim 7.3 the option to use the Blowfish encryption is
"       possible (you can simply set cm=blowfish in your .vimrc but
"       you also need to disable swapfiles, backup files, and
"       viminfo).
"
"       Since I would also like the option to hide (not have visable)
"       as much as I can while editing encrypted files, a method to
"       hide areas in folds is also desirable.
"
"       In addition, I would also like vim to close if and when I get
"       up to go get coffee.
"
"       This plugin loads when a file with file name with the syntax of: 
"             <filename>.auth
"             or
"             <Filename>.auth.<Extension>
"                     
"                     (this allows you to use this plugin with other plugins
"                     like VimWiki)
"         NOTE: If you plan on using this in another plugin, like
"               above, you MUST encrypt the file before hand (as
"               stated In the vim docs). 
"       This plug in will:
"             turn off the swap file
"             turn off the backup file
"             turn off the .viminfo log
"       
"       The other main purpose of this plugin is to ``hide'' passwords in a
"       fold and exit after a set period of time.
"
" INSTALL
"       Put this in your plugin directory and Vim will automatically
"       load it:    ~/.vim/plugin/...
"
" USSAGE 
" (Simple Vim Password Safe)
"
"       If you edit any file named '<filename>.auth.*' then this
"       plugin will add folding features and an automatic quit
"       timeout.
"
"       Vim will quit automatically after 1 minute of no typing
"       activity (unless the file has been changed).
"
"       This plugin will fold on wiki-style headlines in the following
"       format:
"
"           == This is a headline ==
"
"       Any notes under the headline will be inside the fold until the
"       next headline is reached. The SPACE key will toggle a fold
"       open and closed. The q key will quit Vim. Create the following
"       example file named ~/test.auth:  vim -x test.auth
"
"           == There ==
"           username: mary
"           password: 1234
"
"           == Here ==
"           username: Tom 
"           password: 4321

augroup vimcrypt_encrypted
if exists("vimcrypt_encrypted_loaded")
    finish
endif
let vimcrypt_encrypted_loaded = 1
autocmd!

function! s:vimcryptReadPre()
    set viminfo=
    set clipboard=
    set noswapfile
    set nobackup
    set nowritebackup
    set noshelltemp
    set cm=blowfish
endfunction

autocmd BufEnter,BufNewFile,BufReadPre,FileReadPre     *.auth* call s:vimcryptReadPre()

" The following implements a simple folding method for any 'password file' 
" -i.e. Folding is supported for == headlines == style lines.
function! HeadlineDelimiterExpression(lnum)
    if a:lnum == 1
        return ">1"
    endif
    return (getline(a:lnum)=~"^\\s*==.*==\\s*$") ? ">1" : "="
endfunction

autocmd BufReadPost,FileReadPost   *.auth* set foldexpr=HeadlineDelimiterExpression(v:lnum)
autocmd BufReadPost,FileReadPost   *.auth* set foldlevel=0
autocmd BufReadPost,FileReadPost   *.auth* set foldcolumn=0
autocmd BufReadPost,FileReadPost   *.auth* set foldmethod=expr
autocmd BufReadPost,FileReadPost   *.auth* set foldtext=getline(v:foldstart)
autocmd BufReadPost,FileReadPost   *.auth* nnoremap <silent><space> :exe 'silent! normal! za'.(foldlevel('.')?'':'l')<CR>
autocmd BufReadPost,FileReadPost   *.auth* nnoremap <silent>q :q<CR>
autocmd BufReadPost,FileReadPost   *.auth* highlight Folded ctermbg=red ctermfg=black
autocmd BufReadPost,FileReadPost   *.auth* set updatetime=60000
autocmd CursorHold                 *.auth* quit

" End of vimcrypt_encrypted
augroup END
