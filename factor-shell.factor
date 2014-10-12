USING: fry io kernel sequences sets splitting unix.process ;
IN: factor-shell

: tokenize-lines ( str -- seq )
    " " split ;

: run-command ( seq -- )
    [ first ] keep '[ _ _ exec ] [ "parent" print ] with-fork drop ;

: factor-shell ( -- )
    [ "exit" = not [ dup tokenize-lines run-command ] when ] [ readln dup ] do until ;