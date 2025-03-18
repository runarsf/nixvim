{lib, ...}: {
  fromLua = str: ''
    lua << trim EOF
      ${str}
    EOF
  '';

  join = str:
    lib.concatStringsSep " | "
    (lib.filter (line: line != "") (lib.splitString "\n" str));
}
