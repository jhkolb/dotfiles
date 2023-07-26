syntax enable

set nowrap
set visualbell
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set cc=80
set showmatch
set clipboard+=unnamed
set number
set autoindent

" For easy movement between windows
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Autowraps text (nice for txt and md files)
let mapleader=","
nnoremap <leader>q gq0

filetype plugin indent on
autocmd FileType make setlocal noexpandtab
autocmd FileType tex,markdown setlocal wrap spell textwidth=80
autocmd BufRead,BufNewFile *.upc set filetype=c
autocmd BufRead,BufNewFile *.sbt set filetype=scala
autocmd BufNewFile,BufRead *.md set filetype=markdown
autocmd BufNewFile,BufRead *.s,*.S set filetype=asm

" Plugin management with vim-plug
call plug#begin()

Plug 'sainnhe/everforest'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lualine/lualine.nvim'

call plug#end()

" Everforest configuration
let g:everforest_background = 'medium'
let g:everforest_disable_italic_comment = 1
colorscheme everforest

" TreeSitter Configuration (in Lua)
lua <<LUA
require('nvim-treesitter.configs').setup {
    ensure_installed = "all",
    highlight = {
        enable = true,
    },
}
LUA

" LuaLine Configuration (in Lua)
lua <<LUA
require('lualine').setup {
    options = {
        theme = 'everforest',
        icons_enabled = false,
        section_separators = '',
        component_separators = '|',
    },
}
LUA

" If working on Linux source code, try to respect their formatting rules
lua <<LUA
local cwd = vim.fn.getcwd()
if string.match(cwd, "/linux") ~= nil then
    vim.cmd[[
        setlocal noexpandtab
        set tabstop=8
        set softtabstop=8
        set shiftwidth=8
    ]]
end
LUA

" Highlights and automatically removes trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()
