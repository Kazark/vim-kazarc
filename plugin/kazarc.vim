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
call kazarc#SetUpFormatting()
call kazarc#MakeBackspaceFullyFunctional()

set autowrite
cabbr <expr> %% expand('%:p:h')
set diffopt=iwhite

" Enable mouse support in normal mode
set mouse=n " Doesn't seem to do anything on Windows

augroup kazarc
    " C++
    autocmd Filetype cpp setlocal cindent
    autocmd Filetype cpp setlocal cinoptions+=g0
    autocmd Filetype cpp setlocal syntax=cpp11 " How to check whether this is available?
    autocmd BufReadPost *.cpp if !exists('b:current_syntax') " cpp11 hasn't loaded
    autocmd BufReadPost *.cpp     set syntax=cpp " so use regular cpp syntax highlighting
    autocmd BufReadPost *.cpp endif
    " Plain text
    autocmd BufEnter,BufNew *.text setfiletype text
    autocmd Filetype text inoremap <buffer> --- —
    autocmd Filetype text inoremap <buffer> -- –
    autocmd Filetype text setlocal textwidth=80
    autocmd Filetype text setlocal spell
    autocmd Filetype text setlocal nojoinspaces
    autocmd Filetype help setlocal nospell
    " Markdown
    autocmd BufEnter,BufNew *.md setfiletype markdown
    autocmd BufEnter,BufNew *.mkd setfiletype markdown
    autocmd Filetype markdown inoremap <buffer> --- —
    autocmd Filetype markdown inoremap <buffer> -- –
    autocmd Filetype markdown setlocal spell
    autocmd Filetype markdown setlocal nojoinspaces
    autocmd Filetype markdown setlocal textwidth=80
    autocmd Filetype markdown setlocal softtabstop=2
    " Git commit messages
    autocmd Filetype gitcommit setlocal formatoptions-=t
    " Windows resource XML files
    autocmd BufEnter,BufNew *.resx setfiletype xml
augroup end

command -nargs=1 -complete=file Tabv tabe src/<args>.cpp | vs inc/<args>.hpp | sp unittest/<args>Tests.cpp
