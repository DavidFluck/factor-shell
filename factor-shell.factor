USING: fry io kernel sequences sets splitting unix.process system io.launcher formatting ;
IN: factor-shell

: print-prompt ( -- )
    "thing> " printf flush ;

: tokenize-line ( str -- seq )
    " " split ;

: exit-maybe ( x -- x )
    dup "exit" = [ 0 exit ] [ ] if ;

: factor-shell ( -- )
     [ t ] [ print-prompt readln exit-maybe tokenize-line dup last "&" = [ 1 head* " " join run-detached drop ] [ " " join run-process wait-for-process drop ] if ] while ;

MAIN: factor-shell