{
  config,
  lib,
  pkgs,
  ...
}:
# TODO: Exclude grug-far https://github.com/MagicDuck/grug-far.nvim?tab=readme-ov-file#-qa
lib.mkModule config "copilot" {
  performance.combinePlugins.standalonePlugins = ["copilot.lua"];

  plugins = {
    copilot-lua = {
      enable = true;

      settings = {
        panel.enabled = false;
        suggestion.enabled = false; # i rely on completions
      };
    };

    copilot-chat = {
      enable = true;

      settings = {
        question_header = "  ";
        answer_header = "  ";
        error_header = "  ";
        show_help = false;

        window = {
          width = 60;
          border = "none";
        };

        mappings = {
          complete = {
            insert = null;
            normal = null;
          };

          close = {
            insert = null;
            normal = "q";
          };

          reset = {
            insert = null;
            normal = "<localleader>r";
          };

          submit_prompt = {
            insert = "<C-CR>";
            normal = "<CR>";
          };

          toggle_sticky = {
            insert = null;
            normal = "<localleader>s";
          };

          clear_stickies = {
            insert = null;
            normal = "<localleader>S";
          };

          accept_diff = {
            insert = null;
            normal = "<localleader>Y";
          };

          jump_to_diff = {
            insert = null;
            normal = "<localleader>j";
          };

          quickfix_answers = {
            insert = null;
            normal = "<localleader>qa";
          };

          quickfix_diffs = {
            insert = null;
            normal = "<localleader>qd";
          };

          yank_diff = {
            insert = null;
            normal = "<localleader>y";
          };

          show_diff = {
            insert = null;
            normal = "<localleader>d";
            full_diff = false;
          };

          show_info = {
            insert = null;
            normal = "<localleader>i";
          };

          show_context = {
            insert = null;
            normal = "<localleader>c";
          };

          show_help = {
            insert = null;
            normal = "<localleader>h";
          };
        };
      };
    };
  };

  files."ftplugin/copilot-chat.lua" = {
    opts = {
      foldenable = false;
      number = false;
      relativenumber = false;
      wrap = true;
    };
  };

  autoCmd = [
    {
      event = ["BufEnter"];
      pattern = ["copilot-chat"];
      command = "set ft=copilot-chat";
    }
  ];

  keymaps = with lib.utils.keymaps; [
    (mkKeymap' "<F1><F1>" "<CMD>CopilotChatToggle<CR>" "Copilot chat")
    (mkKeymap' "<F1>e" "<CMD>CopilotChatExplain<CR>" "Copilot explain")
    (mkKeymap' "<F1>d" "<CMD>CopilotChatDocs<CR>" "Copilot document")
    (mkKeymap' "<F1>f" "<CMD>CopilotChatFix<CR>" "Copilot fix")
    (mkKeymap' "<F1>o" "<CMD>CopilotChatFix<CR>" "Copilot optimize")
    (mkKeymap' "<F1>r" "<CMD>CopilotChatReview<CR>" "Copilot review")
  ];

  extraLuaPackages = rocks:
    with rocks; [
      tiktoken_core
    ];

  extraPackages = with pkgs; [
    ripgrep
    lynx
  ];
}
