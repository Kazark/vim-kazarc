" Author: Kazark
" Purpose: utility functions for kazarc plugin

function kazarc#SetTabWidthOptionsTo(width)
    let &tabstop=a:width
    let &shiftwidth=&tabstop
    let &softtabstop=&tabstop
endfunction

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
