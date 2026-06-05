{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ripgrep
    fd
    rustup
    nixfmt
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    globals.mapleader = " ";

    opts = {
      number = true;
      tabstop = 2;
      shiftwidth = 2;
      scrolloff = 8;
      mouse = "";
      clipboard = "unnamedplus";
      autowrite = true;
      fillchars.eob = " ";
    };

    colorschemes.catppuccin = {
      enable = true;
      settings.flavour = "mocha";
      transparent_background = true;
    };

    plugins = {
      web-devicons.enable = true;
      treesitter = {
        enable = true;
        settings = {
          highlight.enable = true;
        };
      };

      telescope = {
        enable = true;
        keymaps = {
          "<leader>ff" = "find_files";
          "<leader>fg" = "live_grep";
          "<leader>fb" = "buffers";
          "<leader>fr" = "oldfiles";
          "<leader>fs" = "lsp_document_symbols";
          "<leader>fS" = "lsp_workspace_symbols";
        };
      };

      neo-tree = {
        enable = true;
        settings = {
          filesystem = {
            filtered_items = {
              visible = true;
            };
          };
          window = {
            width = 25;
            mappings = {
              P = {
                command = "toggle_preview";
                config = {
                  use_float = true;
                };
              };
            };
          };
        };
      };

      bufferline.enable = true;

      comment.enable = true;

      lsp = {
        enable = true;
        servers.rust_analyzer = {
          enable = true;
          installCargo = false;
          installRustc = false;
        };
      };

      image = {
        enable = true;
        settings = {
          backend = "kitty";
          hijackFilePatterns = [
            "*.png"
            "*.jpg"
            "*.jpeg"
            "*.gif"
            "*.webp"
          ];
        };
      };

      cmp = {
        enable = true;
        settings = {
          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<Tab>" = "cmp.mapping.select_next_item()";
            "<S-Tab>" = "cmp.mapping.select_prev_item()";
          };
          sources = [ { name = "nvim_lsp"; } ];
        };
      };

      # UI
      lualine.enable = true;
      noice.enable = true;
      indent-blankline.enable = true;

      # Git
      gitsigns.enable = true;

      # Navigation
      harpoon.enable = true;
      flash.enable = true;

      # Editing
      vim-surround.enable = true;
      mini = {
        enable = true;
        modules.pairs = { };
      };

      # LSP / Code
      trouble.enable = true;
      fidget.enable = true;

      which-key.enable = true;
      undotree.enable = true;
      vim-illuminate.enable = true;
      conform-nvim = {
        enable = true;
        settings = {
          format_on_save = {
            lsp_fallback = true;
            timeout_ms = 500;
          };
          formatters_by_ft = {
            rust = [ "rustfmt" ];
            nix = [ "nixfmt" ];
          };
        };
      };

      auto-session.enable = true;
      todo-comments.enable = true;
      # tiny-inline-diagnostic.enable = true;
      toggleterm.enable = true;
      vimwiki.enable = true;
      yazi.enable = true;
      better-escape.enable = true;
      smear-cursor.enable = true;

      tiny-glimmer = {
        enable = true;
        settings = {
          enabled = true;
          animate = {
            yank = true;
            paste = true;
            undo = true;
            redo = true;
          };
        };
      };

      treesitter-textobjects.enable = true;

      visual-multi.enable = true;
      treesitter-context = {
        enable = true;
        settings = {
          max_lines = 4;
          min_window_height = 0;
          multiline_threshold = 1;
        };
      };

      treesj = {
        enable = true;
        settings = {
          max_join_length = 1000;
        };
      };

      project-nvim = {
        enable = true;
        settings = {
          detection_methods = [ "pattern" ];
          patterns = [
            ".git"
            "Cargo.toml"
            "flake.nix"
          ];
        };
      };
    };

    diagnostics = {
      virtual_text = true; # This keeps turning into false for some reason.
      signs = true;
      underline = true;
      update_in_insert = false;
      severity_sort = true;
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>e";
        action = ":Neotree toggle<CR>";
      }
      {
        mode = "n";
        key = "<S-l>";
        action = ":bnext<CR>";
      }
      {
        mode = "n";
        key = "<S-h>";
        action = ":bprev<CR>";
      }
      {
        mode = "n";
        key = "<leader>x";
        action = ":bd<CR>";
      }
      {
        mode = "n";
        key = "gd";
        action = ":lua vim.lsp.buf.definition()<CR>";
      }
      {
        mode = "n";
        key = "gr";
        action = ":lua vim.lsp.buf.references()<CR>";
      }
      {
        mode = "n";
        key = "K";
        action = ":lua vim.lsp.buf.hover()<CR>";
      }
      {
        mode = "n";
        key = "<leader>rn";
        action = ":lua vim.lsp.buf.rename()<CR>";
      }
      {
        mode = "n";
        key = "<leader>ca";
        action = ":lua vim.lsp.buf.code_action()<CR>";
      }
      {
        mode = "n";
        key = "<leader>d";
        action = ":lua vim.diagnostic.open_float()<CR>";
      }
      {
        mode = "i";
        key = "jk";
        action = "<Esc>";
      }

      # Autoformatting
      {
        mode = "n";
        key = "<leader>m";
        action = ":lua vim.lsp.buf.format()<CR>";
      }

      # Window switching
      {
        mode = "n";
        key = "<C-h>";
        action = "<C-w>h";
      }
      {
        mode = "n";
        key = "<C-l>";
        action = "<C-w>l";
      }
      {
        mode = "n";
        key = "<C-j>";
        action = "<C-w>j";
      }
      {
        mode = "n";
        key = "<C-k>";
        action = "<C-w>k";
      }

      # Window resizing
      {
        mode = "n";
        key = "<C-Left>";
        action = ":vertical resize -2<CR>";
      }
      {
        mode = "n";
        key = "<C-Right>";
        action = ":vertical resize +2<CR>";
      }
      {
        mode = "n";
        key = "<C-Up>";
        action = ":resize +2<CR>";
      }
      {
        mode = "n";
        key = "<C-Down>";
        action = ":resize -2<CR>";
      }

      # Move windows with Alt+Shift+hjkl
      {
        mode = "n";
        key = "<A-S-h>";
        action = "<C-w>H";
      }
      {
        mode = "n";
        key = "<A-S-j>";
        action = "<C-w>J";
      }
      {
        mode = "n";
        key = "<A-S-k>";
        action = "<C-w>K";
      }
      {
        mode = "n";
        key = "<A-S-l>";
        action = "<C-w>L";
      }

      # Terminal
      {
        mode = "n";
        key = "<leader>t";
        action = ":botright split | resize 15 | terminal<CR>";
      }

      # Harpoon
      {
        mode = "n";
        key = "<leader>ha";
        action.__raw = "function() require'harpoon':list():add() end";
      }
      {
        mode = "n";
        key = "<leader>hm";
        action.__raw = "function() require'harpoon'.ui:toggle_quick_menu(require'harpoon':list()) end";
      }
      {
        mode = "n";
        key = "<leader>1";
        action.__raw = "function() require'harpoon':list():select(1) end";
      }
      {
        mode = "n";
        key = "<leader>2";
        action.__raw = "function() require'harpoon':list():select(2) end";
      }
      {
        mode = "n";
        key = "<leader>3";
        action.__raw = "function() require'harpoon':list():select(3) end";
      }
      {
        mode = "n";
        key = "<leader>4";
        action.__raw = "function() require'harpoon':list():select(4) end";
      }

      # Flash
      {
        mode = [
          "n"
          "x"
          "o"
        ];
        key = "s";
        action.__raw = "function() require('flash').jump() end";
      }

      # Undotree
      {
        mode = "n";
        key = "<leader>u";
        action = ":UndotreeToggle<CR>";
      }

      # Line movement with Alt+j/k
      {
        mode = "n";
        key = "<A-j>";
        action = ":m+1<CR>";
      }
      {
        mode = "n";
        key = "<A-k>";
        action = ":m-2<CR>";
      }
      {
        mode = "v";
        key = "<A-j>";
        action = ":m+1<CR>gv";
      }
      {
        mode = "v";
        key = "<A-k>";
        action = ":m-2<CR>gv";
      }

      # Copy diagnostic message
      {
        mode = "n";
        key = "<leader>dc";
        action.__raw = "function() local diags = vim.diagnostic.get(0, { lnum = vim.fn.line('.') - 1 }) if diags[1] then vim.fn.setreg('+', diags[1].message) vim.notify('Copied: ' .. diags[1].message) end end";
      }

      # More ergonomic scrolling
      {
        mode = "n";
        key = "<A-d>";
        action = "<C-d>zz";
      }
      {
        mode = "n";
        key = "<A-u>";
        action = "<C-u>zz";
      }

      {
        mode = "n";
        key = "<leader>j";
        action.__raw = "require('treesj').toggle";
      }

      {
        mode = "n";
        key = "]f";
        action.__raw = "function() require('nvim-treesitter-textobjects.move').goto_next_start('@function.outer', 'textobjects') end";
      }

      {
        mode = "n";
        key = "[f";
        action.__raw = "function() require('nvim-treesitter-textobjects.move').goto_previous_start('@function.outer', 'textobjects') end";
      }

      {
        mode = "n";
        key = "]c";
        action.__raw = "function() require('nvim-treesitter-textobjects.move').goto_next_start('@class.outer', 'textobjects') end";
      }

      {
        mode = "n";
        key = "[c";
        action.__raw = "function() require('nvim-treesitter-textobjects.move').goto_previous_start('@class.outer', 'textobjects') end";
      }

      {
        mode = "n";
        key = "<leader>cd";
        action = ":cd "; # leaves the command open for you to type a path
      }
    ];

    extraConfigLua = ''
                  vim.defer_fn(function()
                    vim.diagnostic.config({
                      virtual_text = true,
                      signs = true,
                      underline = true,
                      update_in_insert = false,
                      severity_sort = true,
                    })
                  end, 500)

                  vim.g.VM_maps = {
                    ["Find Under"] = "<C-n>",
                    ["I Exit"] = "jk",  -- exit from VM insert mode
                  } 

            			vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
            				callback = function()
            					if vim.bo.modified and vim.bo.buftype == "" then
            						vim.cmd("silent! write")
            					end
            				end,
            			})
      				vim.defer_fn(function()
      					vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      					vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
      					vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
      					vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
      					vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
      				end, 100)
    '';
  };
}
