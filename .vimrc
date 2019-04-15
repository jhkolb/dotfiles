syntax enable
colorscheme molokai

set hlsearch
set nowrap
set showcmd
set visualbell
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set cc=80
set autoread
set showmatch
set clipboard+=unamed

map <F7> : tabp <ENTER>
map <F8> : tabn <ENTER>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

let g:rehash256=1
set t_Co=256
set term=screen-256color

let mapleader=","
nnoremap <leader>q gq0

filetype plugin indent on
autocmd FileType make setlocal noexpandtab
autocmd FileType tex,markdown setlocal wrap spell
autocmd BufRead,BufNewFile *.upc set filetype=c
autocmd BufRead,BufNewFile *.sbt set filetype=scala
autocmd BufNewFile,BufRead *.md set filetype=markdown
autocmd BufNewFile,BufRead *.s,*.S set filetype=asm
set autoindent

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()
