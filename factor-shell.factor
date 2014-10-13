USING: fry io kernel sequences sets splitting unix.process ;
IN: factor-shell

: print-prompt ( -- )
    "thing" print ;

: tokenize-lines ( str -- seq )
    " " split ;

: run-command ( seq -- )
    [ first ] keep '[ _ _ exec ] [ "parent" print ] with-fork drop ;

: factor-shell ( -- )
    [ "exit" = ] [ readln dup tokenize-lines run-command ] do until ;