USING: fry io kernel sequences sets splitting unix.process system io.launcher formatting io.pathnames io.files.private combinators math.parser continuations ;
QUALIFIED: unix.ffi
IN: factor-shell

: make-prompt ( -- str )
    { } cwd suffix "$ " suffix "" join ;

: print-prompt ( -- )
    make-prompt write flush ;

: tokenize-line ( str -- seq )
    " " split ;

: exit-maybe ( x -- x )
    dup "exit" = [ 0 exit ] [ ] if ;

: try-cd ( x -- )
    [ unix.ffi:chdir ] [ drop "Error changing directories" write ] recover drop ;

: cd-maybe ( x -- x )
    dup
    " " split
    dup
    first
    "cd" =
    [ second try-cd ] [ drop ] if ;

: factor-shell ( -- )
     [ t ] [ print-prompt readln cd-maybe exit-maybe tokenize-line
     {
       { [ dup first "cd" = ] [ 1 tail " " join cd ] }
       { [ dup last "&" = ] [ 1 head* run-detached drop ] }
       [ run-process wait-for-process drop ]
     } cond ] while ;

MAIN: factor-shell
