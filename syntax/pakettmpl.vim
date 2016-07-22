if exists("b:current_syntax")
    finish
endif

syntax case match

syntax match paketTmplKeyword /^type/
syntax match paketTmplKeyword /^id/
syntax match paketTmplKeyword /^version/
syntax match paketTmplKeyword /^description/
syntax match paketTmplKeyword /^releaseNotes/
syntax match paketTmplKeyword /^files/
syntax match paketTmplKeyword /^authors/
syntax match paketTmplKeyword /^owners/
syntax match paketTmplKeyword /^title/
syntax match paketTmplKeyword /^language/
syntax match paketTmplKeyword /^summary/
syntax match paketTmplKeyword /^copyright/
syntax match paketTmplKeyword /^requireLicenseAcceptance/
syntax match paketTmplKeyword /^tags/
syntax match paketTmplKeyword /^developmentDependency/
syntax match paketTmplKeyword /^include-pdbs/
syntax match paketTmplKeyword /^iconUrl/
syntax match paketTmplKeyword /^projectUrl/
syntax match paketTmplKeyword /^licenseUrl/

syntax match paketTmplVersion /\d\(\.\d\)\+/

syntax match paketTmplType /file$/
syntax match paketTmplType /project$/

syntax match paketTmplOp /==>/

" Source: https://gist.github.com/tobym/584909
syntax match paketTmplUrl /https\?:\/\/\(\w\+\(:\w\+\)\?@\)\?\([A-Za-z][-_0-9A-Za-z]*\.\)\{1,}\(\w\{2,}\.\?\)\{1,}\(:[0-9]\{1,5}\)\?\S*/

highlight link paketTmplKeyword Keyword
highlight link paketTmplUrl String
highlight link paketTmplVersion Float
highlight link paketTmplType Constant
highlight link paketTmplOp Operator

let b:current_syntax = "pakettmpl"
