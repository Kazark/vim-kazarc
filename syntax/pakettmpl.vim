if exists("b:current_syntax")
    finish
endif

syntax case match

syntax match paketTmplKeyword /^type/
syntax match paketTmplKeyword /^include-pdbs/
syntax match paketTmplKeyword /^projectUrl/

" Source: https://gist.github.com/tobym/584909
syntax match paketTmplUrl /https\?:\/\/\(\w\+\(:\w\+\)\?@\)\?\([A-Za-z][-_0-9A-Za-z]*\.\)\{1,}\(\w\{2,}\.\?\)\{1,}\(:[0-9]\{1,5}\)\?\S*/

highlight link paketTmplKeyword Keyword
highlight link paketTmplUrl String

let b:current_syntax = "pakettmpl"
