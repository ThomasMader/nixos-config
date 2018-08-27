{ stdenv, writeText }:

let
    generic = builtins.readFile ./vimrc.vim;
in

''
    ${generic}
''

