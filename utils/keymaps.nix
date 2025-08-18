{...}: rec {
  mkKeymap' = mkKeymap "";
  mkKeymap = mode: key: action: descOrOpts: let
    options =
      if builtins.isString descOrOpts
      then {desc = descOrOpts;}
      else descOrOpts;
  in {
    inherit mode key action options;
  };

  mkBufferKeymap' = mkBufferKeymap "";
  mkBufferKeymap = mode: key: action: descOrOpts: let
    options =
      if builtins.isString descOrOpts
      then {desc = descOrOpts;}
      else descOrOpts;
  in {
    inherit mode key action;
    options = options // {buffer = true;};
  };
}
