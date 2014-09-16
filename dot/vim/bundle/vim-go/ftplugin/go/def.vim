if exists("g:go_loaded_godef")
	finish
endif
let g:go_loaded_godef = 1


if !exists("g:go_godef_bin")
	let g:go_godef_bin = "godef"
endif


" modified and improved version of vim-godef
function! Godef(...)
	if !len(a:000)
		" gives us the offset of the word, basicall the position of the word under
		" he cursor
		let arg = s:getOffset()
	else
		let arg = a:1
	endif


	"return with a warning if the bin doesn't exist
	if go#tool#BinExists(g:go_godef_bin) == -1 | return | endif

	let command = g:go_godef_bin . " -f=" . expand("%:p") . " -i " . shellescape(arg)

	" get output of godef
	let out=system(command, join(getbufline(bufnr('%'), 1, '$'), "\n"))

	" jump to it
	call GodefJump(out, "")
endfunction


function! GodefMode(mode)
	let arg = s:getOffset()

	if go#tool#BinExists(g:go_godef_bin) == -1 | return | endif

	let command = g:go_godef_bin . " -f=" . expand("%:p") . " -i " . shellescape(arg)

	" get output of godef
	let out=system(command, join(getbufline(bufnr('%'), 1, '$'), "\n"))

	call GodefJump(out, a:mode)
endfunction


function! s:getOffset()
	let pos = getpos(".")[1:2]
	if &encoding == 'utf-8'
		let offs = line2byte(pos[0]) + pos[1] - 2
	else
		let c = pos[1]
		let buf = line('.') == 1 ? "" : (join(getline(1, pos[0] - 1), "\n") . "\n")
		let buf .= c == 1 ? "" : getline(pos[0])[:c-2]
		let offs = len(iconv(buf, &encoding, "utf-8"))
	endif

	let argOff = "-o=" . offs
	return argOff
endfunction


function! GodefJump(out, mode)
	let old_errorformat = &errorformat
	let &errorformat = "%f:%l:%c"

	if a:out =~ 'godef: '
		let out=substitute(a:out, '\n$', '', '')
		echom out
	else
		let parts = split(a:out, ':')
		" parts[0] contains filename
		let fileName = parts[0]

		" put the error format into location list so we can jump automatically to
		" it
		lgetexpr a:out

		" needed for restoring back user setting this is because there are two
		" modes of switchbuf whic we need based on the split mode
		let old_switchbuf = &switchbuf

		if a:mode == "tab"
			let &switchbuf = "usetab"

			if bufloaded(fileName) == 0
				tab split 
			endif

		else
			let &switchbuf = "useopen"

			if bufloaded(fileName) == 0
				if a:mode  == "split"
					split
				elseif a:mode == "vsplit"
					vsplit
				endif
			endif

		endif

		" jump to file now
		ll 1

		let &switchbuf = old_switchbuf
	end
	let &errorformat = old_errorformat
endfunction

nnoremap <silent> <Plug>(go-def) :<C-u>call Godef()<CR>
nnoremap <silent> <Plug>(go-def-vertical) :<C-u>call GodefMode("vsplit")<CR>
nnoremap <silent> <Plug>(go-def-split) :<C-u>call GodefMode("split")<CR>
nnoremap <silent> <Plug>(go-def-tab) :<C-u>call GodefMode("tab")<CR>

command! -range -nargs=* GoDef :call Godef(<f-args>)
