" Author: Kazark
" Purpose: utility functions for kazarc plugin

if exists('g:kazarc_loaded')
    finish
endif
let g:kazarc_loaded=1

function kazarc#TurnOnFancySearchFeatures()
    set incsearch
    set hlsearch
endfunction

function kazarc#SetBlockCursorInNormalMode()
    let &t_ti.="\e[1 q"
    let &t_SI.="\e[5 q"
    let &t_EI.="\e[1 q"
    let &t_te.="\e[0 q"
endfunction

function kazarc#ConfigureForCygwin()
    call kazarc#SetBlockCursorInNormalMode()
endfunction

function kazarc#MakeBackspaceFullyFunctional()
    set backspace=indent,eol,start
endfunction

function kazarc#SetUpColors()
    syntax on
    if &term == "xterm" || &term == "builtin_gui"
        set t_Co=256
    endif
    try
        colorscheme jellybeans
    catch /^Vim\%((\a\+)\)\=:E185/
        colorscheme elflord
    endtry
endfunction

function kazarc#ConfigureSyntastic()
    let g:syntastic_check_on_open=1
    " C++11
    let g:syntastic_cpp_include_dirs=['inc']
    let g:syntastic_cpp_compiler_options='-std=c++0x -Werror -Wall'
    let g:syntastic_cpp_check_header=1
    " Javascript
    let g:syntastic_javascript_checkers = ['jshint']
endfunction

function kazarc#ConfigureDelimitMate()
    " delimitMate goofs up Vim comments
    " For now, I'm going to just disable delimitMate's autoclosing in Vim
    " files. tpope's endiwse is what is really needed for Vimscript anyway.
    let g:delimitMate_excluded_ft = "vim"
endfunction

function kazarc#ConfigurePlugins()
    filetype plugin on
    call kazarc#ConfigureSyntastic()
    call kazarc#ConfigureDelimitMate()
endfunction

function kazarc#ConfigureForConEmu()
    " Enable 256 color support in ConEmu console emulator
    set term=xterm
    set t_Co=256
    let &t_AB="\e[48;5;%dm"
    let &t_AF="\e[38;5;%dm"
endfunction

function kazarc#ConfigureForWindows()
    " Fix backspace functionality
    if !empty($CONEMUBUILD)
        call kazarc#ConfigureForConEmu()
    endif
endfunction

function kazarc#SetTabWidthOptionsTo(width)
    let &tabstop=a:width
    let &shiftwidth=&tabstop
    let &softtabstop=&tabstop
endfunction

function kazarc#SetUpIndenting()
    call kazarc#SetTabWidthOptionsTo(4)
    filetype plugin indent on
    set autoindent
    set expandtab
endfunction

function kazarc#SetUpFormatting()
    " Comment continuation on following lines
    set formatoptions+=r
    set formatoptions+=o
    " Recognize numbered lists
    set formatoptions+=n
endfunction

function kazarc#ConfigureForPlatform()
    if has("win32")
        call kazarc#ConfigureForWindows()
    endif
    if system('uname -o') == "Cygwin\n"
        call kazarc#ConfigureForCygwin()
    endif
endfunction
