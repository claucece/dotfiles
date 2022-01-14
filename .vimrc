set number
set history=1000
set showcmd
set showmode
set showmatch
set visualbell
set autoread

set hidden
set noswapfile
set nobackup
set nowb

set incsearch
set hlsearch
set ignorecase
set smartcase

filetype indent on

set nocompatible
set foldcolumn=2
set cursorline
set ruler
set columns=150
set lines=42
set ai
set si
set wrap
set wildmenu
set title
set mouse+=a
set nostartofline
set binary
set paste
set clipboard=unnamed
set showmatch
set ttymouse=sgr
set signcolumn=yes


set noerrorbells
set t_vb=
set tm=500

set exrc
set secure

set rtp+=$GOPATH/src/github.com/golang/lint/misc/vim
set runtimepath^=~/.vim/bundle/ctrlp.vim

set backspace=indent,eol,start

if $TMUX == ''
    set clipboard+=unnamed
endif

if exists("g:ctrl_user_command")
    unlet g:ctrlp_user_command
endif

set wildignore+=*.so,*.swp,*.zip

if has("gui_macvim")
     autocmd GUIEnter * set vb t_vb=
     endif
let mapleader = "-"
let maplocalleader = "\\"
let g:lexical#spell = 1
let g:tex_flavor='latex'

vnoremap <leader>u U
nnoremap <leader>ev :vs $MYVIMRC
nnoremap <leader>sv :source $MYVIMRC
nnoremap <leader>qq viw<esc>a"<esc>bi"<esc>lel

let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

syntax enable

autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4
autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype gitcommit setlocal spell textwidth=72
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritePost,FileWritePost *.go execute 'Lint' | cwindow
autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
autocmd! BufEnter,BufNewFile *.go syntax on
autocmd! BufLeave *.go syntax off

augroup lexical
  autocmd!
  autocmd FileType markdown,mkd call lexical#init()
  autocmd FileType textile call lexical#init()
  autocmd FileType html call lexical#init()
  autocmd FileType text call lexical#init({ 'spell': 0 })
augroup END

let &colorcolumn="80,".join(range(120,999),",")
highlight ColorColumn ctermbg=195 guibg=#d7ffff

filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-fugitive'

Plugin 'scrooloose/nerdcommenter'

Plugin 'govim/govim'

Plugin 'rust-lang/rust.vim'

Plugin 'vim-airline/vim-airline'

Plugin 'reedes/vim-lexical'

Plugin 'xolox/vim-lua-ftplugin'

Plugin 'tpope/vim-eunuch'

Plugin 'xolox/vim-misc'

Plugin 'mattn/emmet-vim'

Plugin 'vim-scripts/indentpython.vim'

Plugin 'pangloss/vim-javascript'

Plugin 'LaTeX-Suite-aka-Vim-LaTeX'

call vundle#end()

execute pathogen#infect()
syntax on
filetype plugin indent on

let g:go_fmt_command = "goimports"

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_echo_command_info=1
let g:go_debug=['shell-commands']

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

let g:syntastic_go_checkers = ['go', 'golint', 'errcheck']
let g:rustfmt_autosave = 1

let g:javascript_plugin_jsdoc = 1

map <C-n> :NERDTreeToggle<CR>
map <c-k> :pyf /usr/local/Cellar/clang-format/2017-06-22/share/clang/clang-format.py<cr>
imap <c-k> <c-o>:pyf /usr/local/Cellar/clang-format/2017-06-22/share/clang/clang-format.py<cr>

au Filetype go nnoremap <leader>v :vsp <cr>:exe "GoDef" <cr>
au Filetype go nnoremap <leader>s :sp <cr>:exe "GoDef"<cr>
au Filetype go nnoremap <leader>t :tab split <cr>:exe "GoDef"<cr>
onoremap in( :<c-u>normal! f(vi(<cr>

function! <SID>StripTrailingWhitespaces()
    " save last search & cursor position
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction

" Suggestion: show info for completion candidates in a popup menu
if has("patch-8.1.1904")
  set completeopt+=popup
  set completepopup=align:menu,border:off,highlight:Pmenu
endif
