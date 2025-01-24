{ config, lib, pkgs, ... }:

{
  options.modules.duck.enable = lib.mkEnableOption "duck";

  config = lib.mkIf config.modules.duck.enable {
    extraConfigLua = ''
      local actions = require('telescope.actions')
      local action_state = require('telescope.actions.state')

      function Pet()
        local pets = { '🐀', '🦆', '🦦', '🐕', '🦽', '🦮', '🦥', '🦠', '🦟', '🦔', '🦑', '🦐', '🐢', '🐍', '🪱', '🐌', '🦈', '🦀', '🐟', '🪰', '🪳', '🪲' }
        local speed_for = {
          ['🐌'] = '2',
          ['🦟'] = '50',
        }

        require('telescope.pickers').new({}, {
          prompt_title = 'Select Pet',
          finder = require('telescope.finders').new_table({
            results = pets,
          }),
          sorter = require('telescope.sorters').get_generic_fuzzy_sorter(),
          attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
              local selection = action_state.get_selected_entry()
              actions.close(prompt_bufnr)

              -- Defer the number input to ensure the environment is ready
              vim.defer_fn(function()
                local speed = speed_for[selection[1]]

                if speed == nil then
                  local input_opts = {
                    prompt = 'Choose Speed',
                    default = '7',
                  }

                  vim.ui.input(input_opts, function(input)
                    local number = tonumber(input) or 7.0
                    require('duck').hatch(selection[1], number)
                  end)
                else
                  require('duck').hatch(selection[1], speed)
                end
              end, 100)
            end)
            return true
          end
        }):find()
      end
    '';

    keymaps = [
      {
        key = "<leader>ps";
        action = "<CMD>lua Pet()<CR>";
        options.desc = "Spawn pet :⁾";
      }
      {
        key = "<leader>pk";
        action = "<CMD>lua require('duck').cook_all()<CR>";
        options.desc = "Kill pets :⁽";
      }
    ];

    extraPlugins = with pkgs.vimPlugins; [ duck ];
  };
}

