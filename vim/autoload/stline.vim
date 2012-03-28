function! stline#Fileenconding()
	if &fileencoding != ''
		return &fileencoding
	elseif &encoding != ''
		return &encoding
	else
		return '--'
	endif
endfunction

function! stline#Filetype()
	if &filetype != ''
		return &filetype
	endif
	return '--'
endfunction

function! stline#Fileformat()
	if &fileformat != ''
		return &fileformat
	endif
	return '--'
endfunction

function! stline#Fileinfo(separator)
	return join([stline#Fileformat(), stline#Fileenconding(), stline#Filetype()], a:separator)
endfunction

function! stline#Bufferstate()
	if &buftype == 'help'
		return 'h'
	elseif &readonly || &buftype == 'nowrite'
		return '-'
	elseif &modified 
		return '*'
	endif
	return '+'
endfunction

function! stline#Filename()
	"let filename = expand("%:p:t")
	let filename = expand("%:t")

	return filename != '' ? filename : "No File"
endfunction

function! stline#Tabinfo()
    if &expandtab
        return 'softtabstop:' . &softtabstop
	else
        return 'tabstop:' . &tabstop
    endif

endfunction
