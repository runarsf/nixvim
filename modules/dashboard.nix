{
  config,
  lib,
  helpers,
  pkgs,
  ...
}:
{
  options.modules.dashboard.enable = lib.mkEnableOption "dashboard";

  config = lib.mkIf config.modules.dashboard.enable {
    extraPackages = with pkgs; [
      krabby
      colorized-logs
    ];

    extraLuaPackages = rocks: with rocks; [ luautf8 ];

    modules.snacks.enable = true;

    plugins = {
      lazy.enable = true;

      snacks.settings.dashboard = {
        enabled = true;
        sections = [
          (helpers.mkRaw "GetPokemonSection()")
        ];
      };
    };

    extraConfigLuaPre =
      # lua
      ''
        utf8 = require("lua-utf8")

        function RunCommand(command)
          local handle = assert(io.popen(command, 'r'))
          local output = assert(handle:read("*a"))

          handle:close()

          return output:gsub("^(\n+)", ""):gsub("(\n+)$", "")
        end

        function RemoveAnsiCodes(str)
          return RunCommand("printf '" .. str .. "' | ansi2txt")
        end

        function GetRandomPokemon()
          local n = math.random(100)
          local generate_shiny = n == 27
          local pokemon_command = "krabby name growlithe --no-title"

          if generate_shiny then
            pokemon_command = pokemon_command .. " --shiny"
          end

          return RunCommand(pokemon_command)
        end

        function GetPokemonSection()
          local pokemon = GetRandomPokemon()
          local lines = vim.split(pokemon, "\n")
          local height = #lines
          local width = 0

          for _, line in ipairs(lines) do
            local clean_line = RemoveAnsiCodes(line)
            local line_length = utf8.len(clean_line)
            if line_length > width then
              width = line_length or 0
            end
          end

          return {
            section = "terminal",
            cmd = "printf '" .. pokemon .. "'",
            height = height,
            width = width,
          }
        end
      '';

    globals.minitrailspace_disable = true;

    autoCmd = [
      {
        event = "BufNew";
        callback =
          helpers.mkRaw
            # lua
            ''
              function()
                vim.g.minitrailspace_disable = false
              end
            '';
      }
    ];
  };
}
# {
#   config,
#   lib,
#   helpers,
#   pkgs,
#   ...
# }: {
#   options.modules.dashboard.enable = lib.mkEnableOption "dashboard";
#
#   config = lib.mkIf config.modules.dashboard.enable {
#     extraPackages = with pkgs; [fortune-kind];
#
#     plugins.alpha = {
#       enable = true;
#       opts = {
#         margin = 5;
#       };
#       layout = helpers.mkRaw "alpha_layout()";
#     };
#
#     extraConfigLuaPre = lib.concatStringsSep "\n" [(builtins.readFile ./quotes.lua) (builtins.readFile ./alpha.lua)];
#   };
# }
