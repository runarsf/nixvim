{
  config,
  lib,
  helpers,
  ...
}: {
  options.modules.buffers.enable = lib.mkEnableOption "buffers";

  config = lib.mkIf config.modules.buffers.enable {
    plugins = {
      bufferline = {
        enable = true;
        settings.options = {
          diagnostics = "nvim_lsp";
          show_buffer_close_icons = false;
          always_show_bufferline = false;
          style_preset = helpers.mkRaw "require('bufferline').style_preset.no_bold";
        };
      };
    };

    keymaps = [
      {
        key = "<C-t>";
        action = "<CMD>enew<CR>";
        mode = "n";
        options.desc = "Create a new buffer";
      }
      {
        key = "<S-l>";
        action = "<CMD>bnext<CR>";
        options.desc = "Next buffer";
      }
      {
        key = "<S-h>";
        action = "<CMD>bprevious<CR>";
        options.desc = "Previous buffer";
      }
      {
        key = "<leader>q";
        action = "<CMD>lua close_buffer()<CR>";
        options.desc = "Close buffer";
      }
      {
        key = "<leader>Q";
        action = "<CMD>qall<CR>";
        options.desc = "Quit";
      }
      {
        key = "<leader><Tab>";
        action =
          if config.plugs.telescope.enable
          then "<CMD>Telescope buffers<CR>"
          else "<CMD>ls<CR>";
        options.desc = "List buffers";
      }
    ];

    extraConfigLua = ''
      count_bufs_by_type = function(loaded_only)
        loaded_only = (loaded_only == nil and true or loaded_only)
        count = {normal = 0, acwrite = 0, help = 0, nofile = 0,
        nowrite = 0, quickfix = 0, terminal = 0, prompt = 0}
        buftypes = vim.api.nvim_list_bufs()
        for _, bufname in pairs(buftypes) do
          if (not loaded_only) or vim.api.nvim_buf_is_loaded(bufname) then
              buftype = vim.api.nvim_buf_get_option(bufname, 'buftype')
              buftype = buftype ~= "" and buftype or 'normal'
              count[buftype] = count[buftype] + 1
          end
        end
        return count
      end

      function close_buffer()
        local bufTable = count_bufs_by_type()
        if (bufTable.normal <= 1) then
          local result = vim.api.nvim_exec([[:q]], true)
        else
          local result = vim.api.nvim_exec([[${
        if (config.plugins.snacks.enable && config.plugins.snacks.settings.bufdelete.enabled)
        then ":lua Snacks.bufdelete()"
        else ":bprevious | bdelete #"
      }]], true)
        end
      end
    '';
  };
}
