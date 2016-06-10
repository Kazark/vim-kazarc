if exists("b:current_syntax")
    finish
endif

syntax case match

syntax match berksfileKeyword /^source/
syntax match berksfileKeyword /^metadata/
syntax match berksfileKeyword /^cookbook/

syntax match berksfileSymbol /\~>/
syntax match berksfileSymbol /'/
syntax match berksfileVersion /\d\(\.\d\)\+/

" Source: https://gist.github.com/tobym/584909
syntax match berksfileUrl /https\?:\/\/\(\w\+\(:\w\+\)\?@\)\?\([A-Za-z][-_0-9A-Za-z]*\.\?\)\{1,}\(\w\{2,}\.\?\)\{1,}\(:[0-9]\{1,5}\)\?\S*/

highlight link berksfileKeyword Keyword
highlight link berksfileSymbol Operator
highlight link berksfileVersion Float
highlight link berksfileUrl String

let b:current_syntax = "berksfile"
