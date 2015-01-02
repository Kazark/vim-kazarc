" Author: Kazark
" Purpose: initialize Vim

if exists('g:kazarc_loaded_plugin')
    finish
endif
let g:kazarc_loaded_plugin=1

call kazarc#ConfigureForPlatform()
call kazarc#SetUpIndenting()
call kazarc#TurnOnFancySearchFeatures()
call kazarc#SetUpColors()
call kazarc#ConfigurePlugins()
call kazarc#MakeBackspaceFullyFunctional()
call kazarc#HideToolAndMenuBarInGUI()

let mapleader=","

set autowrite " So `:make`, `:cnfile`, etc, are easier to use
set autoread " Why prompt unless there is danger of loosing something?
set diffopt=iwhite " To my mind, this should be opt-in instead of opt-out

" Enable mouse support in normal mode
set mouse=n " Doesn't seem to do anything on Windows

" Make sure we get column and row displayed
set ruler

" So you don't have to use \c while searching. Seems like a good idea. I'll
" try it out.
set ignorecase smartcase

" Go(lang) Vim runtime path
set runtimepath+=$GOROOT/misc/vim

" Why hold down the shift key? The default mapping of ; is not very useful
nmap ; :
vmap ; :

" Screw Vi-compatibility; let's make sense around here
" From http://vimrcfu.com/snippet/88
map Y y$

" Neovim is going to kill Ex mode. That means, as far as I'm concerned, Q is
" free. And :noh is a perennial nuisance...
nnoremap <silent> Q :nohlsearch<CR>

" From http://vimrcfu.com/snippet/14
" "It's stupid that indenting or unindenting a visual block deselects the
" block. Automatically 'gv' (go to previously selected visual block) after
" indenting or unindenting." --@dwieeb
vnoremap < <gv
vnoremap > >gv

" From http://vimrcfu.com/snippet/106
nnoremap <Tab> >>
nnoremap <S-Tab> <LT><LT>
vnoremap <Tab> >gv
vnoremap <S-Tab> <LT>gv

" I select everything in a file far more than I increment an integer! Why not
" make CTRL-A do what it does in almost every other program?
nmap <C-a> ggVG

" CTRL-C doesn't do anything valuable in Normal or Visual mode. Why not map it
" to what it does in almost every other program (CUA)?
vmap <C-c> "+y
nmap <C-c> "+yy

" Similarly, while I do not want to overwrite the mapping of control v (it's
" default Vim behavior is too valuable), why not create something similar?
map <leader><C-v> "+p

" Like ZZ and ZQ...
nmap <silent> ZA :qa<CR>

" Underscore-related motions
map <leader>w f_l
map <leader>b hT_
map <leader>e lt_
omap u t_
omap U f_

" Map s to surround in visual mode from Tim Pope's Surround plugin
xmap s <Plug>VSurround
" One of the most common things I do with Surround is to surround a single
" word with ` in a Markdown file
nmap <leader>` ves`<Esc>

" Tab mappings analogous to window mappings where <leader>t is like <C-w>
map <silent> <leader>tc :tabclose<CR>
map <silent> <leader>tn :tabnew<CR>

augroup kazarc
    " C++ syntax highlighting; default to C++11
    autocmd Filetype cpp setlocal syntax=cpp11 " How to check whether this is available?
    autocmd BufReadPost *.cpp if !exists('b:current_syntax') " cpp11 hasn't loaded
    autocmd BufReadPost *.cpp     setlocal syntax=cpp " so use regular cpp syntax highlighting
    autocmd BufReadPost *.cpp endif
    " JavaScript fragments (e.g. intro.js.frag)
    autocmd Filetype jsfragment setlocal syntax=javascript
    " Leave diff mode when using Git if file has no corresponding file to diff with
    autocmd VimEnter * call kazarc#IfStartedInDiffModeCloseNulGitBufferIfAny()
augroup end
