"Mon Sep 20 13:57:35 CEST 2010
"Thu Feb  9 22:31:42 CET 2012
set nocompatible
syn on
set showcmd
set mouse=a
set autoindent
set incsearch
set ignorecase " when searching
set smartcase " but not when I use uppercase
set number
set wildchar=<Tab>
set scrolloff=3
set clipboard=unnamed
set magic
set autochdir
"set lazyredraw "udajne zrychli makra
set noerrorbells
set diffopt=vertical
colorscheme darkblue

" Set some handy shorcuts for moving in tabs
nnoremap <S-l> gt
nnoremap <S-h> gT

set nohlsearch

"nefunguje
"set statusline=%n:\ %f%m%r%h%w\ [%Y,%{&fileencoding},%{&fileformat}]\ [%l-%L,%v][%p%%]
"nefunguje
set statusline=
set statusline+=%h%1*%m%r%w%0*               " flags
set statusline+=\[%{strlen(&ft)?&ft:'none'}, " filetype
set statusline+=%{&encoding},                " encoding
set statusline+=%{&fileformat}]              " file format
if filereadable(expand("$VIM/vimfiles/plugin/vimbuddy.vim"))
    set statusline+=\ %{VimBuddy()}          " vim buddy
endif
set statusline+=%=                           " right align
set statusline+=%2*0x%-8B\                   " current char
set statusline+=%-14.(%l,%c%V%)\ %<%P        " offset

"show trailing whitespaces on not whitespaces-only lines but not that just typed in insert mode
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\(\S\)\@<=\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\(\S\)\@<=\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\(\S\)\@<=\s\+$/
autocmd BufWinLeave * call clearmatches()

set tabstop=4 "jak velky tab je
set shiftwidth=4 "kolik sloupcu odsadi >> <<
set expandtab "vloz misto tabu mezery
set backspace=2
set softtabstop=4 "4 mezery jdou smazat jako tab
"set noet neexpanduj tabelatory "ted nevim, jestli to chci?
"syntax match Tab /\t/ "zvyrazni taby
"hi Tab gui=underline guifg=blue ctermbg=blue

filetype plugin on
runtime plugin/matchparen.vim
DoMatchParen

map  :w
imap  :w
"map k :%s/^\(.*\){\*}/{\1*}/g
"map l :%s/^{\(.*\)\*}/\1{*}/g
map k :%s/^\(.*\)\/\*C\*\//\/*\1C*\//g
map l :%s/^\/\*\(.*\)C\*\//\1\/\*C\*\//g
"map j I{A *}
map <F5> :set hls!<bar>set hls?<CR>

"tabulatory prepinaji panely
map <C-Tab> gt
imap <C-Tab> gt
map <C-S-Tab> gT
imap <C-S-Tab> gT
set hidden

map  :r ! date
imap  :r ! date
map  I\begin{frame}\end{frame}
map <F9> :w:make
imap <F9> :w:make

"map p ]p
"map P ]P

"set gfn=Terminus\ 10
set go-=T
set go-=m
set go-=r

"set viminfo='50,n~/vim/viminfo
set viminfo='20,\"50,n~/.viminfo

if has('gui_running')
else
    hi CursorLine cterm=NONE ctermbg=black
    :autocmd InsertEnter * set cul
    :autocmd InsertLeave * set nocul
endif


"pageup

map <silent> <PageUp> <nop>
map <silent> <PageDown> <nop>
imap <silent> <PageUp> <nop>
imap <silent> <PageDown> <nop>

map <silent> <F1> <nop>
imap <silent> <F1> <nop>

"ctags
map <silent> gc <C-]>

map ds %x``x


autocmd BufNewFile *.latex :set lbr
autocmd BufNewFile *.txt :set lbr

autocmd BufReadPre *.txt :set lbr
autocmd BufReadPre *.latex :set lbr

autocmd BufNewFile *.plog :set syn=prolog
autocmd BufReadPre *.plog :set syn=prolog

set guifont=Monospace\ 12
map <F3> :! ~/bin/xterm &<CR><CR>

