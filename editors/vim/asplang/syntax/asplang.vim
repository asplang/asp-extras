" Vim syntax file
" Language: Asp
" Contact:  info@asplang.org
" URL:      https://asplang.org
" Copying:  You may distribute and use this file freely, in the same way as the
"           vim editor itself.

if exists("b:current_syntax")
    finish
endif

syntax case match

" Keywords.
syntax keyword aspConstant None
syntax keyword aspBoolean False True
syntax keyword aspStatement as assert break continue def del local global pass
syntax keyword aspStatement return
syntax keyword aspConditional elif else if
syntax keyword aspRepeat for while
syntax keyword aspOperator and in is not or
syntax keyword aspInclude from import
syntax keyword aspReserved class except exec finally lambda nonlocal raise try
syntax keyword aspReserved with yield

" Strings with embedded escape sequences.
syntax region aspString
    \ start=/\v\z(['"])/ skip=/\V\\|\\\z1/ end=/\v\z1/
    \ contains=aspEscape
syntax match aspEscape /\v\\[abfnrtv\'\"\\]/ contained
syntax match aspEscape /\v\\x\x{2}/ contained
syntax match aspEscape /\v\\\d{3}/ contained

" Identifiers.
syntax match aspIdentifier /\v<\h\w*>/

" Special characters.
let s:aspOpChars = '!%&*+\-./:<=>^`|~'
let s:aspValidChars = s:aspOpChars . '"#''(),;\[\\\]{}[:ident:][:space:]'
exec 'syntax match aspError _\V\[^' . s:aspValidChars . ']_'
exec 'syntax match aspError _\V\[' . s:aspOpChars . ']_'
syntax match aspOperator _\V\[+\-*/%<>=&^|.`~]_
syntax match aspDelimiter _\V\[,:;]_
syntax match aspSpecial _\V\\_
syntax match aspOperator _\V\(\[*/<>.=]\)\1_
syntax match aspOperator _\V\[+\-*/%<>&^|!]=_
syntax match aspOperator _\V<-_
syntax match aspOperator _\V\(\[*/<>]\)\1=_
syntax match aspOperator _\V<=>_
syntax match aspConstant "\V..."

" Numbers.
syntax match aspNumber /\v\d+/
syntax match aspFloat /\v(\d*\.)?\d+([eE][\+-]?\d+)?/
syntax match aspNumber /\v0[xX]\x+/
syntax match aspNumber /\v0[bB][01]+/

" Comments.
syntax match aspComment "\v\#.*$"

" Highlighting.
highlight link aspComment Comment
highlight link aspConstant Constant
highlight link aspBoolean Boolean
highlight link aspNumber Number
highlight link aspFloat Float
highlight link aspString String
highlight link aspEscape SpecialChar
highlight link aspIdentifier Identifier
highlight link aspStatement Statement
highlight link aspConditional Conditional
highlight link aspRepeat Repeat
highlight link aspOperator Operator
highlight link aspInclude Include
highlight link aspSpecial Special
highlight link aspDelimiter Delimiter
highlight link aspReserved Error
highlight link aspError Error

let b:current_syntax = "asplang"
