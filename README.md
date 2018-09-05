# Toop

The most native way of extending your Vim.

Create custom text-object operations.

Toop stands for Text Objects OPerations. 

Or also [Tim pOpe](https://github.com/tpope) [Original](http://vim.wikia.com/wiki/Act_on_text_objects_with_custom_functions) Project (with extensions).


## Usage Examples

```vim
"make json objects beautiful
call toop#mapShell('jq .', '<leader>jb')
"unescape an object
call toop#mapShell('sed "s/\\\//g" ', '<leader>u')



"single quote
call toop#mapAround("'", "<leader>'")
"double quote
call toop#mapAround('"', '<leader>"')
"markdown italic
call toop#mapAround('*', '<leader>it')
"markdown bold
call toop#mapAround('**', '<leader>bo')



"using async
fun! GoogleIt(str)
    execute 'AsyncRun $BROWSER "'.a:str.'"'
endfunc
call toop#mapFunction('GoogleIt', '<leader>gi')

fun! FoldSomething(str)
    let comment=split(&commentstring, '%s')
    if len(l:comment)==1
        call add(comment, l:comment[0])
    endif
    return l:comment[0]." {{{\n".a:str."\n".l:comment[1]."}}}"
endfun
call toop#mapFunction('FoldSomething', '<leader>fo')

```

After having mapped some behaviour you can use it in the following ways:


- After a visual selection `<C-v><leader>jb`
- with a text object `is<leader>jb`
- with the current line by repeat the last key of the stroke `<leader>jbb`


Enjoy!
