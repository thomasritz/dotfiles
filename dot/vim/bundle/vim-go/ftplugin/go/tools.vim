if exists("g:go_loaded_gotools")
    finish
endif
let g:go_loaded_gotools = 1


" Some handy plug mappings
nnoremap <silent> <Plug>(go-run) :<C-u>call go#command#Run(expand('%'))<CR>
nnoremap <silent> <Plug>(go-build) :<C-u>call go#command#Build('')<CR>
nnoremap <silent> <Plug>(go-install) :<C-u>call go#command#Install()<CR>
nnoremap <silent> <Plug>(go-test) :<C-u>call go#command#Test('')<CR>
nnoremap <silent> <Plug>(go-coverage) :<C-u>call go#command#Coverage('')<CR>
nnoremap <silent> <Plug>(go-vet) :<C-u>call go#command#Vet()<CR>
nnoremap <silent> <Plug>(go-files) :<C-u>call go#tool#Files()<CR>
nnoremap <silent> <Plug>(go-deps) :<C-u>call go#tool#Deps()<CR>
nnoremap <silent> <Plug>(go-info) :<C-u>call go#complete#Info()<CR>
nnoremap <silent> <Plug>(go-import) :<C-u>call GoSwitchImport(1, '', expand('<cword>'))<CR>

nnoremap <silent> <Plug>(go-implements) :<C-u>call go#oracle#Implements(-1)<CR>

command! -range=% GoImplements call go#oracle#Implements(<count>)

command! -nargs=0 GoFiles echo go#tool#Files()
command! -nargs=0 GoDeps echo go#tool#Deps()
command! -nargs=* GoInfo call go#complete#Info()

command! -nargs=* -range -bang GoRun call go#command#Run(<bang>0,<f-args>)
command! -nargs=? -range -bang GoBuild call go#command#Build(<bang>0)

command! -nargs=* GoInstall call go#command#Install(<f-args>)
command! -nargs=* GoTest call go#command#Test(<f-args>)
command! -nargs=* GoCoverage call go#command#Coverage(<f-args>)
command! -nargs=0 GoVet call go#command#Vet()


" Disable all commands until they are fully integrated.
"
" command! -range=% GoOracleDescribe call go#oracle#Describe(<count>)
" command! -range=% GoOracleCallees  call go#oracle#Callees(<count>)
" command! -range=% GoOracleCallers call go#oracle#Callers(<count>)
" command! -range=% GoOracleCallgraph call go#oracle#Callgraph(<count>)
" command! -range=% GoOracleCallstack call go#oracle#Callstack(<count>)
" command! -range=% GoOracleFreevars call go#oracle#Freevars(<count>)
" command! -range=% GoOraclePeers call go#oracle#Peers(<count>)
" command! -range=% GoOracleReferrers call go#oracle#Referrers(<count>)

" vim:ts=4:sw=4:et
"

