let s:save_cpo = &cpo
set cpo&vim

let s:cmp = 'stridx(v:val, l:pat) >= 0'

" Get the path separator for this platform.
function! s:pathsep()
    for l:w in ['win16', 'win32', 'win64', 'win95']
        if has(l:w)
            return ';'
        endif
    endfor
    return ':'
endfunction

function! MUcompleteMinisnip#candidates() abort
	if !exists("g:pathsep")
	  let g:pathsep = s:pathsep()
	endif

	for l:dir in split(g:minisnip_dir, g:pathsep)
		echo l:dir
		let l:global_snippets = map(glob(l:dir . '/[^_]*', v:false, v:true), {key, val ->
			\ fnamemodify(val, ':t')})
		let l:filetype_snippets = map(glob(l:dir . '/_' . &filetype . '_*', v:false,
			\ v:true), {key, val -> substitute(fnamemodify(val, ':t'), '^_' . &filetype . '_', '',
			\ '')})
	endfor
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
