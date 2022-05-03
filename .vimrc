set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Added
" Plugin 'davidhalter/jedi-vim'
Plugin 'rust-lang/rust.vim'
Plugin 'udalov/kotlin-vim'
Plugin 'nvie/vim-flake8'
Plugin 'leafgarland/typescript-vim'
let g:flake8_cmd="/home/matej/bin/flake8"

Plugin 'Chiel92/vim-autoformat'
" To disable the fallback to vim's indent file, retabbing and removing
" trailing whitespace, set the following variables to 0.
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
"filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"Plugin 'Valloric/YouCompleteMe'

set nocompatible
syn on
set showcmd
set mouse=a

" indent new line as the previous one
set autoindent

" jump to matching string while I'm typing the pattern
set incsearch

set ignorecase " when searching
set smartcase " but not when I use uppercase

set wildignorecase "filename completion

" don't highlight matching string
set nohlsearch

" show line numbers
set number

set wildchar=<Tab>
set scrolloff=3
set clipboard=unnamed
set magic

set autochdir " to the directory containing the file being edited
set noerrorbells
set diffopt=vertical

" tell it to use an undo file
set undofile
" set a directory to store the undo history
set undodir=$HOME/.vimundo/

" show trailing whitespaces but not these just typed in insert mode
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" how long tab is
set tabstop=4
" how many columns does << >> (un)indent
set shiftwidth=4
" spaces instead of tab
set expandtab
set backspace=2
" 4 spaces can be deleted as one tab
set softtabstop=4
" when shifting a non-aligned set of lines, align them to the next tabstop
set shiftround
set hidden

filetype plugin on
runtime plugin/matchparen.vim
DoMatchParen

let mapleader = ","

" ctrl-s saves
map  :w
imap  :w

"map k :%s/^\(.*\){\*}/{\1*}/g
"map l :%s/^{\(.*\)\*}/\1{*}/g
map k :%s/^\(.*\)\/\*C\*\//\/*\1C*\//g
map l :%s/^\/\*\(.*\)C\*\//\1\/\*C\*\//g
"map j I{A *}

" F5 switches highlight search
map <F5> :set hls!<bar>set hls?<CR>

map <F3> :! ~/bin/xterm &<CR><CR>
map gb :! ~/bin/xterm -e git blame % &<CR><CR>
map ,w :%s/\s\+$//
map ,s :bufdo :set noswapfile swapfile
map ,S ,s<Up>:s/, /,\r/g
nnoremap ,b :ls<CR>:b<Space>

" ctrl-(shift)-tab switches tabs
map <C-Tab> gt
imap <C-Tab> gt
map <C-S-Tab> gT
imap <C-S-Tab> gT


map  :r ! date
imap  :r ! date

" F9 runs make
map <F9> :w:make:cw
imap <F9> :w:make:cw

" save file with sudo when opened read-only
cmap w!! %!sudo tee > /dev/null %

"cmap json .! python -mjson.tool

"map p ]p
"map P ]P

"set gfn=Terminus\ 10
set go-=T
set go-=m
set go-=r

" use viminfo file to remember lot of useful stuff
set viminfo='20,\"50,n~/.viminfo

if has('gui_running')
    colorscheme darkblue
else
    hi CursorLine cterm=NONE ctermbg=black
    :autocmd InsertEnter * set cul
    :autocmd InsertLeave * set nocul
    colorscheme torte
endif

" do nothing
map <silent> <PageUp> <nop>
map <silent> <PageDown> <nop>
imap <silent> <PageUp> <nop>
imap <silent> <PageDown> <nop>
map <silent> <F1> <nop>
imap <silent> <F1> <nop>

"ctags
map <silent> gc <C-]>
map gC :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map gV :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" delete one pair of matching parentheses
map ds %x``x

" add empty line below
map ,o moo`o
" add empty line above
map ,O moO`o

" add python breakpoint
map ,p oimport pdb; pdb.set_trace()

" underline markdown style
map == yyp:s/./=/g<CR>
map =- yyp:s/./-/g<CR>

" assign arguments to self inside python __init__
let @i = '%wwwvt:€klyopa, :€ku€kl€kl€kl€kl€kl€kl€kl€kl€kl€kl€kl€kl€kl€kl€kl€kl€kl€kl€kl:'

map ,s :bufdo :set noswapfile swapfile<CR>

autocmd BufNewFile *.html 0r ~/bin/novy.html
autocmd BufNewFile *.latex 0r ~/bin/novy.latex
autocmd BufNewFile *.cpp 0r ~/bin/novy.cpp
autocmd BufNewFile *.sh 0r ~/bin/novy.sh
autocmd BufNewFile *.latex :set lbr
autocmd BufNewFile *.txt :set lbr

autocmd BufReadPre *.txt :set lbr
autocmd BufReadPre *.latex :set lbr
autocmd BufReadPre *.tex :set lbr

autocmd BufNewFile *.plog :set syn=prolog
autocmd BufReadPre *.plog :set syn=prolog
autocmd BufNewFile *.prolog :set syn=prolog
autocmd BufReadPre *.prolog :set syn=prolog
autocmd BufNewFile *.tex :set syn=tex
autocmd BufReadPre *.tex :set syn=tex

au BufRead,BufNewFile *.djt set filetype=django
au BufRead,BufNewFile *.html set filetype=django
au BufRead,BufNewFile *.html set syn=htmldjango
au BufRead,BufNewFile *.md set filetype=markdown


"let g:clang_snippets = 1
"let g:clang_snippets_engine = 'clang_complete'

"set conceallevel=2
"set concealcursor=vin
"let g:clang_snippets=1
"let g:clang_conceal_snippets=1
"" The single one that works with clang_complete
"let g:clang_snippets_engine='clang_complete'

"" Complete options (disable preview scratch window, longest removed to aways
"" show menu)
"set completeopt=menu,menuone

"" Limit popup menu height
"set pumheight=20

"execute pathogen#infect()

"let g:jedi#completions_command = "<C-N>"
let g:jedi#goto_stubs_command = ""

" CTRL-U and CTRL-W in insert mode cannot be undone.  Use CTRL-G u to first
" break undo, so that we can undo those changes after inserting a line break.
" For more info, see: http://vim.wikia.com/wiki/Recover_from_accidental_Ctrl-U
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>

let b:did_indent = 1


"let g:ycm_global_ycm_extra_conf = '.ycm_extra_conf.py'

autocmd BufRead,BufNewFile /home/matej/Dokumenty/mam/mamweb2/mamweb/*.py setlocal ts=4 sw=4 expandtab backspace=2 softtabstop=4



