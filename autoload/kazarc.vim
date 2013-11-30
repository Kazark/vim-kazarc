" Author: Kazark
" Purpose: utility functions for kazarc plugin

function kazarc#SetTabWidthOptionsTo(width)
    let &tabstop=a:width
    let &shiftwidth=&tabstop
    let &softtabstop=&tabstop
endfunction

