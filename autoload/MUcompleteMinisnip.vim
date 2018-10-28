let s:save_cpo = &cpo
set cpo&vim

let s:cmp = 'stridx(v:val, l:pat) >= 0'

function! MUcompleteMinisnip#candidates() abort
    let l:global_snippets = map(glob(g:minisnip_dir . '/[^_]*', v:false, v:true), {key, val ->
        \ fnamemodify(val, ':t')})
    let l:filetype_snippets = map(glob(g:minisnip_dir . '/_' . &filetype . '_*', v:false,
        \ v:true), {key, val -> substitute(fnamemodify(val, ':t'), '^_' . &filetype . '_', '',
        \ '')})
    return l:global_snippets + l:filetype_snippets
endfunction

function! MUcompleteMinisnip#complete() abort
    let l:pat = matchstr(getline('.'), '\S\+\%' . col('.') . 'c')
    if len(l:pat) < 1
        return ''
    endif
    if !exists('b:snippet_candidates')
        let b:snippet_candidates = MUcompleteMinisnip#candidates()
    endif
    let l:candidates = map(filter(copy(b:snippet_candidates), s:cmp),
        \ '{
        \      "word": v:val,
        \      "menu": "[snip] " . v:val,
        \      "dup": 1
        \ }')
    if !empty(l:candidates)
        call complete(col('.') - len(l:pat), l:candidates)
    endif
    return ''
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
