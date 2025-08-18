local M = {}

local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

M.PickPet = function()
  local pets = { '🐀', '🦆', '🦦', '🐕', '🦽', '🦮', '🦥', '🦠', '🦟', '🦔', '🦑', '🦐', '🐢', '🐍', '🪱', '🐌', '🦈', '🦀', '🐟', '🪰', '🪳',
    '🪲' }
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
        local pet = action_state.get_selected_entry()[1]
        actions.close(prompt_bufnr)

        -- Defer the number input to ensure the environment is ready
        vim.defer_fn(function()
          local speed = speed_for[pet]

          if speed == nil then
            local input_opts = {
              prompt = 'Choose Speed: ',
              default = '7',
            }

            vim.ui.input(input_opts, function(input)
              local number = tonumber(input) or 7.0

              -- Get the duck module (call the function returned by require)
              -- This seems to be a workaround for when it's lazy loaded
              local duck = require('duck')
              duck.hatch(pet, number)
            end)
          else
            local duck = require('duck')
            duck.hatch(pet, tonumber(speed))
          end
        end, 100)
      end)
      return true
    end
  }):find()
end

return M
