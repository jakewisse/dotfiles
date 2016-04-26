set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'
Plugin 'scrooloose/nerdtree'
Plugin 'kchmck/vim-coffee-script'
Plugin 'groenewege/vim-less'
Plugin 'scrooloose/nerdcommenter'
Plugin 'bling/vim-airline'
Plugin 'kien/ctrlp.vim'
Plugin 'StanAngeloff/php.vim'
Plugin 'rking/ag.vim'
Plugin 'qualiabyte/vim-colorstepper'
Plugin 'flazz/vim-colorschemes'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-surround'
Plugin 'mattn/emmet-vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'scrooloose/syntastic'
Plugin 'tomtom/tcomment_vim'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'jdkanani/vim-material-theme'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
" Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Tab settings
set expandtab
autocmd FileType javascript setlocal ts=2 sts=2 sw=2
autocmd FileType html setlocal ts=2 sts=2 sw=2
autocmd FileType python setlocal ts=4 sts=4 sw=4
autocmd FileType coffee setlocal ts=4 sts=4 sw=4
autocmd FileType markdown setlocal ts=2 sts=2 sw=2
autocmd FileType gitcommit setlocal ts=2 sts=2 sw=2

" Wrap at 80
au FileType markdown setlocal textwidth=80
au FileType commitmsg setlocal textwidth=80

" Line numbers
set numberwidth=3
set number
nmap <c-l><c-i> :set invnumber<CR>

" NERDTree key commands
map <C-n> :NERDTreeToggle<CR>

" Remove trailing whitespace
nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" Toggle windows
nnoremap <Leader>w <C-w><C-w>

" Show status line always
set laststatus=2

" Use Ag with CtrlP
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
endif

" Various CtrlP settings
let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore='\v[\/]node_modules$'

" K to search word under cursor
nnoremap <silent> K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" Search
set hlsearch
set incsearch

" Colorstepper key bindings
nmap <F7> <Plug>ColorstepPrev
nmap <F8> <Plug>ColorstepNext
nmap <S-F7> <Plug>ColorstepReload

" Emmet settings
let g:user_emmet_install_global=0
au FileType html,css EmmetInstall

" Multiple cursors settings
let g:multi_cursor_use_default_mapping=0

let g:multi_cursor_next_key='<C-m>'
let g:multi_cursor_prev_key='<C-k>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

" Timestamps
nnoremap T "=strftime("%c")<CR>P
nnoremap t "=strftime("%c")<CR>p
vnoremap t "=strftime("%c")<CR>p

" Syntax and colorscheme
syntax on
colo grb256

let g:markdown_fenced_languages = [ 'coffee', 'css', 'js=javascript', 'javascript', 'json=javascript', 'xml' ]

" Use [patched airline font](https://github.com/powerline/fonts)
let g:airline_powerline_fonts = 1

" Don't show status bar underneath airline
set noshowmode

command! ToggleWrap call ToggleWrap()
function! ToggleWrap()
  if &wrap
    echo "Wrap OFF"
    setlocal nowrap
    set virtualedit=all
    silent! nunmap <buffer> <Up>
    silent! nunmap <buffer> <Down>
    silent! nunmap <buffer> <Home>
    silent! nunmap <buffer> <End>
    silent! iunmap <buffer> <Up>
    silent! iunmap <buffer> <Down>
    silent! iunmap <buffer> <Home>
    silent! iunmap <buffer> <End>
  else
    echo "Wrap ON"
    setlocal wrap linebreak nolist
    set virtualedit=
    setlocal display+=lastline
    noremap  <buffer> <silent> <Up>   gk
    noremap  <buffer> <silent> <Down> gj
    noremap  <buffer> <silent> <Home> g<Home>
    noremap  <buffer> <silent> <End>  g<End>
    inoremap <buffer> <silent> <Up>   <C-o>gk
    inoremap <buffer> <silent> <Down> <C-o>gj
    inoremap <buffer> <silent> <Home> <C-o>g<Home>
    inoremap <buffer> <silent> <End>  <C-o>g<End>
  endif
endfunction

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:airline#extensions#syntastic#enabled = 1
let g:syntastic_javascript_checkers = ['eslint']

