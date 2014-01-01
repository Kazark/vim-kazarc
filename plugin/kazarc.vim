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

" Enable mouse support in normal mode
set mouse=n " Doesn't seem to do anything on Windows

augroup kazarc
    " C++
    autocmd Filetype cpp     set cindent
    autocmd Filetype cpp     set cinoptions+=g0
    autocmd Filetype cpp     set syntax=cpp11 " How to check whether this is available?
    autocmd BufReadPost *.cpp   if !exists('b:current_syntax') " cpp11 hasn't loaded
    autocmd BufReadPost *.cpp       set syntax=cpp " so use regular cpp syntax highlighting
    autocmd BufReadPost *.cpp   endif
    " Plain text
    autocmd BufEnter,BufNew *.txt setfiletype text
    autocmd BufEnter,BufNew *.text setfiletype text
    autocmd Filetype text inoremap <buffer> --- —
    autocmd Filetype text inoremap <buffer> -- –
    autocmd Filetype text set textwidth=80
    autocmd Filetype text set spell
    autocmd Filetype text set nojoinspaces
    " Markdown
    autocmd BufEnter,BufNew *.md setfiletype markdown
    autocmd BufEnter,BufNew *.mkd setfiletype markdown
    autocmd Filetype markdown set spell
    autocmd Filetype markdown set nojoinspaces
    autocmd Filetype markdown set textwidth=80
    " Git commit messages
    autocmd Filetype gitcommit setlocal formatoptions-=t
augroup end

command -nargs=1 -complete=file Tabv tabe src/<args>.cpp | vs inc/<args>.hpp | sp unittest/<args>Tests.cpp
