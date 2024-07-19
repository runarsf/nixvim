_:

{
  plugins.fidget = {
    enable = true;
    progress = {
      ignore = [ "dartls" ];
      ignoreDoneAlready = true;
      suppressOnInsert = true;
    };
  };
}
