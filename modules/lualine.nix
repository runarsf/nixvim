{
  config,
  lib,
  pkgs,
  helpers,
  ...
}:
lib.mkModule config "lualine" {
  performance.combinePlugins.standalonePlugins = ["lualine.nvim"];

  utils = [
    {
      "lualine" =
        # lua
        ''
          local M = {}

          M.BufferLanguageColor = function()
            local filename = vim.fn.expand("%:t")
            local _, color = require("nvim-web-devicons").get_icon_color(filename)
            return color
          end

          return M
        '';
    }
  ];

  plugins.lualine = {
    enable = true;
    settings = {
      extensions = [
        "trouble"
        "toggleterm"
        "nvim-dap-ui"
        "symbols-outline"
      ];
      sections = {
        lualine_a = [
          {
            __unkeyed = "mode";
            padding = {
              left = 1;
              right = 0;
            };
            fmt =
              # lua
              ''
                function(mode)
                  local result = ""
                  for part in string.gmatch(mode, "[^-]+") do
                    if #part > 0 then
                      local first_char = string.upper(string.sub(part, 1, 1))
                      result = result .. first_char
                    end
                  end
                  return result
                end
              '';
          }
        ];
        lualine_b = [
          "branch"
          "diagnositcs"
          "diff"
        ];
        lualine_c = [
          {
            __unkeyed = "filename";
            path = 1;
            symbols = {
              modified = "•";
              readonly = "󰏯 ";
              unnamed = "Unnamed";
              newfile = "New file";
            };
            cond =
              helpers.mkRaw
              # lua
              ''
                function()
                  local ignored_filename_patterns = {
                    "^$",
                    "^neo%-tree filesystem %[%d+%]$",
                    "#toggleterm#%d+",
                    "^dap-view%:%/%/.*",
                    "^%[dap%-repl%-%d+%]$",
                  }

                  local filename = vim.fn.expand("%:t")

                  for _, pattern in ipairs(ignored_filename_patterns) do
                    if string.find(filename, pattern) then
                      return false
                    end
                  end

                  return true
                end
              '';
          }
        ];
        lualine_x = [
          {
            __unkeyed = "lsp_status";
            ignore_lsp = ["copilot"];
            icon = {
              __unkeyed = "󰗊";
              # TODO: lualine doesn't update this color on refresh, it only runs once
              color.fg =
                helpers.mkRaw
                # lua
                "require('utils.lualine').BufferLanguageColor()";
            };
            symbols.done = "";
            fmt =
              # lua
              ''
                function(lsp_status)
                  local ignored = {
                    "emmet_language_server",
                  }

                  local seen = {}
                  local unique = {}

                  for ls in lsp_status:gmatch("%S+") do
                    if not seen[ls] and not vim.tbl_contains(ignored, ls) then
                      table.insert(unique, ls)
                      seen[ls] = true
                    end
                  end

                  lsp_status = table.concat(unique, " ")

                  -- otter-ls has stuff after it, so i can't use ignore_lsp
                  return lsp_status:gsub("otter%-ls%[.+%]", ""):gsub("%s+$", "")
                end
              '';
          }
          ''
            if vim.o.paste then return "P" else return "" end
          ''
          ''
            if #vim.o.mouse > 0 then return "M" else return "" end
          ''
          "encoding"
          {
            __unkeyed = "filetype";
            cond =
              helpers.mkRaw
              # lua
              ''
                function()
                  local ignored_filetypes = {
                    "neo-tree",
                    "TelescopePrompt",
                    "TelescopeResults",
                    "toggleterm",
                    "dap-repl",
                    "trouble",
                    "dap-view",
                    "neo-tree-popup",
                    "snacks_dashboard",
                  }

                  return not vim.tbl_contains(ignored_filetypes, vim.bo.filetype)
                end
              '';
          }
        ];
        lualine_y = [
          "selectioncount"
          "searchcount"
        ];
      };
      options = {
        component_separators = {
          left = "";
          right = "";
        };
        section_separators = {
          left = "";
          right = "";
        };
      };
      component_separators = {
        left = "";
        right = "";
      };
      section_separators = {
        left = "";
        right = "";
      };
    };
  };
}
