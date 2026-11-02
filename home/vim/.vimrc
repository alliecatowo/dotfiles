" Plain vim, for boxes without Neovim. The real editor setup is LazyVim in ~/.config/nvim.
set nocompatible
syntax on
filetype plugin indent on
set number relativenumber
set expandtab shiftwidth=2 tabstop=2 smartindent
set ignorecase smartcase incsearch hlsearch
set hidden mouse=a clipboard=unnamed
set undofile undodir=~/.vim/undo//
set scrolloff=8 signcolumn=yes
let mapleader = " "
nnoremap <leader>w :w<CR>
nnoremap <Esc> :nohlsearch<CR>
