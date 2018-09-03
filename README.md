# Custom action on text objects

Create your own actions and have fun!


Examples:


fun! s:foldSomething(str)
    let comment=split(&commentstring, '%s')
    if len(l:comment)==1
        call add(comment, l:comment[0])
    endif
    return l:comment[0]." {{{\n".a:str."\n".l:comment[1]."}}}"
endfun

call MapAction('foldSomething', '<leader>fo')
