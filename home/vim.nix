{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ripgrep
    fd
    rustup
    nixfmt
    direnv
    nix-direnv
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
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
      guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20";
    };

    colorschemes.catppuccin = {
      enable = true;
      settings = {
        flavour = "mocha";
        transparent_background = true;
      };
    };


    plugins = {
   #    web-devicons.enable = true;
      treesitter = {
        enable = true;
        settings = {
          highlight.enable = true;
        };
      };

      telescope = {
        enable = true;
        keymaps = {
          "<leader>f" = "find_files";
          "<leader>g" = "live_grep";
          "<leader>b" = "buffers";
          "<leader>o" = "oldfiles";
          "<leader>s" = "lsp_document_symbols";
          "<leader>S" = "lsp_workspace_symbols";
        };
        settings = {
          defaults.vimgrep_arguments = [
            "rg"
            "--color=never"
            "--no-heading"
            "--with-filename"
            "--line-number"
            "--column"
            "--smart-case"
            "--hidden"
            "--glob"
            "!**/.git/*"
          ];
          pickers.find_files = {
            find_command = [
              "rg"
              "--files"
              "--hidden"
              "--glob"
              "!**/.git/*"
            ];
          };
        };
			};

			auto-save = {
				enable = true;
				settings = {
					enabled = true;
					trigger_events = {
						immediate_save = [ "BufLeave" "FocusLost" ];
						defer_save = [ "InsertLeave" "TextChanged" ];
					};
					debounce_delay = 25;
					condition.__raw = ''
						function(buf)
							local fn = vim.fn
							local utils = require("auto-save.utils.data")
							if fn.getbufvar(buf, "&modifiable") == 1 and utils.not_in(fn.getbufvar(buf, "&filetype"), {}) then
								return true
							end
							return false
						end
					'';
				};
			};

   #    # neo-tree = {
   #    #   enable = true;
   #    #   settings = {
   #    #     filesystem = {
   #    #       filtered_items = {
   #    #         visible = true;
   #    #       };
   #    #     };
   #    #     window = {
   #    #       width = 25;
   #    #       mappings = {
   #    #         P = {
   #    #           command = "toggle_preview";
   #    #           config = {
   #    #             use_float = true;
   #    #           };
   #    #         };
   #    #       };
   #    #     };
   #    #   };
   #    # };
			#
      bufferline.enable = true;
   #    comment.enable = true;
			# mini-align.enable = true;
			kitty-scrollback = {
				enable = true;
				settings = {
					scrollback_yank_register = false;
				};
			};

      lsp = {
        enable = true;
        servers = {
          nixd = {
            enable = true;
            settings = {
              nixd = {
                nixpkgs.expr = "import <nixpkgs> { }";
                # formatting.command = [ "alejandra" ];
                options = {
                  nixos.expr = ''(builtins.getFlake "/home/alysara/.dotfiles").nixosConfigurations.nixos.options'';
                  home-manager.expr = ''(builtins.getFlake "/home/alysara/.dotfiles").homeConfigurations."alysara".options'';
                };
              };
            };
          };

					ts_ls.enable = true;

          rust_analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
            settings = {
              checkOnSave = true;
              check.command = "clippy";
              cargo.allFeatures = true;
              rustfmt.overrideCommand = null;
              server.extraEnv = {
                RUSTUP_TOOLCHAIN = "nightly";
              };
            };
          };
        };
      };

   #    image = {
   #      enable = true;
   #      settings = {
   #        backend = "kitty";
   #        hijackFilePatterns = [
   #          "*.png"
   #          "*.jpg"
   #          "*.jpeg"
   #          "*.gif"
   #          "*.webp"
   #        ];
   #      };
   #    };
			#
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
			# lualine = {
			# 	enable = true;
			# 	settings = {
			# 		options = {
			# 			component_separators = { left = ""; right = ""; };
			# 			section_separators = { left = ""; right = ""; };
			# 		};
			# 		sections = {
			# 			lualine_a = [
			# 				{
			# 					__unkeyed-1 = "mode";
			# 					separator = { left = ""; };
			# 				}
			# 			];
			# 			lualine_b = [ "branch" "diff" "diagnostics" ];
			# 			lualine_c = [ "filename" ];
			# 			lualine_x = [ "filetype" ];
			# 			lualine_y = [ "progress" ];
			# 			lualine_z = [
			# 				{
			# 					__unkeyed-1 = "location";
			# 					separator = { right = ""; };
			# 				}
			# 			];
			# 		};
			# 	};
			# };
			#
   #    noice.enable = true;
   #    # indent-blankline.enable = true;
			#
   #    # Git
   #    gitsigns.enable = true;
			#
   #    # Navigation
   #    harpoon.enable = true;
      flash.enable = true;
			#
   #    # Editing
      vim-surround.enable = true;
      mini = {
        enable = true;
        modules.pairs = { };
      };
			#
   #    # LSP / Code
			trouble = {
				enable = true;
				settings = {
					focus = true;
					win = {
						type = "float";
						border = "rounded";
					};
					preview = {
						type = "float";
						border = "rounded";
					};
					keys = {
						o = "jump";
						"<cr>" = "jump_close";
						"<esc>" = "close";
					};
				};
			};
   #    # fidget.enable = true;
			#
      which-key = {
				enable = true;
				settings.preset = "helix";
			};

      undotree.enable = true;
   #    # vim-illuminate.enable = true;
   #    # conform-nvim = {
   #    #   enable = true;
   #    #   settings = {
   #    #     # format_on_save = {
   #    #     #   lsp_fallback = true;
   #    #     #   timeout_ms = 500;
   #    #     # };
   #    #     formatters_by_ft = {
   #    #       rust = [ "rustfmt" ];
   #    #     };
   #    #   };
   #    # };
			#
   #   #  auto-session = {
   #   #    enable = true;
   #   #    settings = {
   #   #      auto_save = true;
   #   #      auto_restore = true;
   #   #      session_lens.load_on_setup = false;
   #   #      bypass_save_filetypes = [
   #   #        "toggleterm"
   #   #        "terminal"
   #   #      ];
			# 		# auto_session_enabled.__raw = "vim.env.KITTY_SCROLLBACK_NVIM ~= 'true'";
   #   #    };
   #   #  };
   #    # todo-comments.enable = true;
   #    # tiny-inline-diagnostic.enable = true;
			#
   #    # toggleterm = {
   #    #   enable = true;
   #    #   settings = {
   #    #     direction = "float";
   #    #     float_opts = {
   #    #       border = "none";
   #    #       width.__raw = "vim.o.columns";
   #    #       height.__raw = "vim.o.lines";
   #    #     };
   #    #   };
   #    # };
   #    # vimwiki.enable = true;
			
      yazi.enable = true;
      better-escape.enable = true;

   #    # smear-cursor.enable = false;
			#
   #    # tiny-glimmer = {
   #    #   enable = true;
   #    #   settings = {
   #    #     enabled = true;
   #    #     animate = {
   #    #       yank = true;
   #    #       paste = true;
   #    #       undo = true;
   #    #       redo = true;
   #    #     };
   #    #   };
   #    # };
			#
      treesitter-textobjects.enable = true;
			#
   #    # visual-multi.enable = true;
      treesitter-context = {
        enable = true;
        settings = {
          max_lines = 4;
          min_window_height = 0;
          multiline_threshold = 2;
        };
      };
			#
      treesj = {
        enable = true;
        settings = {
          max_join_length = 1000;
        };
      };
			#
   #    # project-nvim = {
   #    #   enable = true;
   #    #   settings = {
   #    #     detection_methods = [ "pattern" ];
   #    #     patterns = [
   #    #       ".git"
   #    #       "flake.nix"
   #    #     ];
   #    #   };
   #    # };
			#
   #    # nix-develop.enable = true;
   #    # direnv = {
   #    #   enable = true;
   #    #   settings.silent_load = 1;
   #    # };
			#
      colorizer = {
        enable = true;
        settings = {
          user_default_options = {
            RGB = true;
            RRGGBB = true;
            names = false; # disable named colors like "red" (noisy)
            RRGGBBAA = true;
            rgb_fn = true; # highlight css rgb() functions
            hsl_fn = true;
            mode = "background"; # or "foreground" or "virtualtext"
          };
        };
      };
			#
      abolish.enable = true;
    };

    diagnostic.settings = {
      virtual_text = true; # This keeps turning into false for some reason.
      signs = true;
      underline = true;
      update_in_insert = true;
      severity_sort = true;
    };

    keymaps = [
      { options.desc = "Next buffer";            mode = "n"; key = "<S-l>";      action = ":bnext<CR>";                           }
      { options.desc = "Previous buffer";        mode = "n"; key = "<S-h>";      action = ":bprev<CR>";                           }
      { options.desc = "Close buffer";           mode = "n"; key = "<leader>x";  action = ":bd<CR>";                              }
      { options.desc = "Go to definition";       mode = "n"; key = "gd";         action = ":lua vim.lsp.buf.definition()<CR>";    }
      { options.desc = "Go to references";       mode = "n"; key = "gr";         action = ":lua vim.lsp.buf.references()<CR>";    }
      { options.desc = "Hover info";             mode = "n"; key = "K";          action = ":lua vim.lsp.buf.hover()<CR>";         }
      { options.desc = "Rename symbol";          mode = "n"; key = "<leader>r";  action = ":lua vim.lsp.buf.rename()<CR>";        }
      { options.desc = "Code action";            mode = "n"; key = "<leader>a";  action = ":lua vim.lsp.buf.code_action()<CR>";   }
      { options.desc = "View diagnostic";        mode = "n"; key = "<leader>d";  action = ":lua vim.diagnostic.open_float()<CR>"; }
      { options.desc = "Escape";                 mode = "i"; key = "jk";         action = "<Esc>";                                }

      # Autoformatting
      { options.desc = "Format buffer";          mode = "n"; key = "<leader>m";  action = ":lua vim.lsp.buf.format()<CR>";        }

      # Window switching
      { options.desc = "Focus left";             mode = "n"; key = "<C-h>";      action = "<C-w>h";                               }
      { options.desc = "Focus right";            mode = "n"; key = "<C-l>";      action = "<C-w>l";                               }
      { options.desc = "Focus up";               mode = "n"; key = "<C-j>";      action = "<C-w>j";                               }
      { options.desc = "Focus down";             mode = "n"; key = "<C-k>";      action = "<C-w>k";                               }

      # Window resizing
      { options.desc = "Resize left";            mode = "n"; key = "<C-Left>";   action = ":vertical resize -2<CR>";              }
      { options.desc = "Resize right";           mode = "n"; key = "<C-Right>";  action = ":vertical resize +2<CR>";              }
      { options.desc = "Resize up";              mode = "n"; key = "<C-Up>";     action = ":resize +2<CR>";                       }
      { options.desc = "Resize down";            mode = "n"; key = "<C-Down>";   action = ":resize -2<CR>";                       }

      # Move windows with Alt+Shift+hjkl
      { options.desc = "Move buffer left";       mode = "n"; key = "<A-S-h>";    action = "<C-w>H";                               }
      { options.desc = "Move buffer right";      mode = "n"; key = "<A-S-l>";    action = "<C-w>L";                               }
      { options.desc = "Move buffer up";         mode = "n"; key = "<A-S-k>";    action = "<C-w>K";                               }
      { options.desc = "Move buffer down";       mode = "n"; key = "<A-S-j>";    action = "<C-w>J";                               }

      # Undotree
      { options.desc = "Undotree";               mode = "n"; key = "<leader>u";  action = ":UndotreeToggle<CR>";                  }

      # Line movement with Alt+j/k
      { options.desc = "Move line down";         mode = "n"; key = "<A-j>";      action = ":m+1<CR>";                             }
      { options.desc = "Move line up";           mode = "n"; key = "<A-k>";      action = ":m-2<CR>";                             }
      { options.desc = "Move selection down";    mode = "v"; key = "<A-j>";      action = ":m+1<CR>gv";                           }
      { options.desc = "Move selection up";      mode = "v"; key = "<A-k>";      action = ":m-2<CR>gv";                           }

      # More ergonomic scrolling
      { options.desc = "Join or split";          mode = "n"; key = "<leader>j";  action.__raw = "require('treesj').toggle";       }

      { options.desc = "Search projects";        mode = "n"; key = "<leader>p";  action = ":AutoSession search<CR>";              }
      { options.desc = "Toggle terminal";        mode = "n"; key = "<leader>e";  action = ":ToggleTerm<CR>";                      }

      { options.desc = "Yazi current directory"; mode = "n"; key = "<leader>yy"; action = "<cmd>Yazi<cr>";                        }
      { options.desc = "Yazi working directory"; mode = "n"; key = "<leader>yw"; action = "<cmd>Yazi cwd<cr>";                    }
      { options.desc = "Cancel search";          mode = "n"; key = "<leader>/";  action = ":nohlsearch<CR>";                      }
 			# Native is <C-^> which is the worst shortcut ever.
      { options.desc = "Previous buffer";        mode = "n"; key = "<leader>c";  action = ":b#<CR>";                              }

			{
				options.desc = "Toggle diagnostics (workspace)";
				mode = "n";
				key = "<leader>D";
				action = ":Trouble diagnostics toggle<CR>";
			}

			{
				options.desc = "Toggle diagnostics (buffer)";
				mode = "n";
				key = "<leader>Alt-d";
				action = ":Trouble diagnostics toggle filter.buf=0<CR>";
			}

      {
				options.desc = "Toggle inlay hints"; mode = "n"; key = "<leader>i";
				action.__raw = "function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end";
			}

      # Harpoon
      {
				options.desc = "Add buffer to harpoon"; mode = "n"; key = "<leader>ha";
				action.__raw = "function() require'harpoon':list():add() end";
			}
      {
				options.desc = "List harpoon buffers"; mode = "n"; key = "<leader>hm";
				action.__raw = "function() require'harpoon'.ui:toggle_quick_menu(require'harpoon':list()) end";
			}
      {
				options.desc = "Harpoon buffer 1"; mode = "n"; key = "<leader>1";
				action.__raw = "function() require'harpoon':list():select(1) end";
			}
      {
				options.desc = "Harpoon buffer 2"; mode = "n"; key = "<leader>2";
				action.__raw = "function() require'harpoon':list():select(2) end";
			}
      {
				options.desc = "Harpoon buffer 3"; mode = "n"; key = "<leader>3";
				action.__raw = "function() require'harpoon':list():select(3) end";
			}
      {
				options.desc = "Harpoon buffer 4"; mode = "n"; key = "<leader>4";
				action.__raw = "function() require'harpoon':list():select(4) end";
			}

      # Flash
      {
				options.desc = "Flash jump"; mode = [ "n" "x" "o" ]; key = "s";
				action.__raw = "function() require('flash').jump() end";
			}

      # Treesitter mappings.
      {
        options.desc = "Goto start of next method"; mode = ["n" "v"]; key = "]m";
				action.__raw = "function() require('nvim-treesitter-textobjects.move').goto_next_start('@function.outer', 'textobjects') end";
			}
      {
        options.desc = "Goto end of next method"; mode = ["n" "v"]; key = "]M";
				action.__raw = "function() require('nvim-treesitter-textobjects.move').goto_next_end('@function.outer', 'textobjects') end";
			}
      {
        options.desc = "Goto start of previous method"; mode = ["n" "v"]; key = "]m";
				action.__raw = "function() require('nvim-treesitter-textobjects.move').goto_previous_start('@function.outer', 'textobjects') end";
			}
      {
        options.desc = "Goto end of previous method"; mode = ["n" "v"]; key = "[M";
				action.__raw = "function() require('nvim-treesitter-textobjects.move').goto_previous_end('@function.outer', 'textobjects') end";
			}

      {
        options.desc = "Goto start of next type"; mode = ["n" "v"]; key = "]t";
				action.__raw = "function() require('nvim-treesitter-textobjects.move').goto_next_start('@class.outer', 'textobjects') end";
			}
      {
        options.desc = "Goto end of next type"; mode = ["n" "v"]; key = "]T";
				action.__raw = "function() require('nvim-treesitter-textobjects.move').goto_next_end('@class.outer', 'textobjects') end";
			}
      {
        options.desc = "Goto start of previous type"; mode = ["n" "v"]; key = "[t";
				action.__raw = "function() require('nvim-treesitter-textobjects.move').goto_previous_start('@class.outer', 'textobjects') end";
			}
      {
        options.desc = "Goto end of previous type"; mode = ["n" "v"]; key = "[T";
				action.__raw = "function() require('nvim-treesitter-textobjects.move').goto_previous_end('@class.outer', 'textobjects') end";
			}

      {
        options.desc = "Goto start of next comment"; mode = ["n" "v"]; key = "]c";
				action.__raw = "function() require('nvim-treesitter-textobjects.move').goto_next_start('@comment.outer', 'textobjects') end";
			}
      {
        options.desc = "Goto end of next comment"; mode = ["n" "v"]; key = "]C";
				action.__raw = "function() require('nvim-treesitter-textobjects.move').goto_next_end('@comment.outer', 'textobjects') end";
			}
      {
        options.desc = "Goto start of previous comment"; mode = ["n" "v"]; key = "[c";
				action.__raw = "function() require('nvim-treesitter-textobjects.move').goto_previous_start('@comment.outer', 'textobjects') end";
			}
      {
        options.desc = "Goto end of previous comment"; mode = ["n" "v"]; key = "[C";
				action.__raw = "function() require('nvim-treesitter-textobjects.move').goto_previous_end('@comment.outer', 'textobjects') end";
			}

      {
        options.desc = "Around method"; mode = ["x" "o"]; key = "am";
				action.__raw = "function() require('nvim-treesitter-textobjects.select').select_textobject('@function.outer', 'textobjects') end";
			}
      {
        options.desc = "Inner method"; mode = ["x" "o"]; key = "im";
				action.__raw = "function() require('nvim-treesitter-textobjects.select').select_textobject('@function.inner', 'textobjects') end";
			}
      {
        options.desc = "Around type"; mode = ["x" "o"]; key = "at";
				action.__raw = "function() require('nvim-treesitter-textobjects.select').select_textobject('@class.outer', 'textobjects') end";
			}
      {
        options.desc = "Inner type"; mode = ["x" "o"]; key = "it";
				action.__raw = "function() require('nvim-treesitter-textobjects.select').select_textobject('@class.inner', 'textobjects') end";
			}
      {
        options.desc = "Around scope"; mode = ["x" "o"]; key = "as";
				action.__raw = "function() require('nvim-treesitter-textobjects.select').select_textobject('@local.scope', 'locals') end";
			}

    ];

		extraConfigLua = ''
			vim.api.nvim_create_user_command('BDA', function()
				for _, buf in ipairs(vim.api.nvim_list_bufs()) do
					vim.api.nvim_buf_delete(buf, { force = true })
				end
			end, {})

			require('kitty-scrollback').setup({
				yank_register_enabled = false,
			})
		'';
  # 	-- init = function()
  # 	-- 	vim.cmd.colorscheme('catppuccin-mocha')
  # 	-- end,)
  #
  # --     							vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
  # --     								callback = function()
  # --     									if vim.bo.modified and vim.bo.buftype == "" then
  # --     										vim.defer_fn(function()
  # --     											vim.cmd("silent! write")
  # --     										end, 5)
  # --     									end
  # --     								end,
  # --     							})
  # --
  # --     							vim.api.nvim_create_autocmd("TermOpen", {
  # --     								callback = function()
  # --     									vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  # --     									vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  # --     								end,
  # --     							})
  #     							-- vim.defer_fn(function()
  #     							-- 	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  #     							-- 	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  #     							-- 	vim.api.nvim_set_hl(0, "FloatTitle", { bg = "none" })
  #     							-- 	vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
  #     							-- 	vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
  #     							-- 	vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
  #     							-- 	vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
  #     							-- 	vim.api.nvim_set_hl(0, "DiagnosticFloatingInfo", { bg = "none" })
  #     							-- end, 100)
  # --     								vim.api.nvim_create_autocmd("DirChanged", {
  # --     								callback = function()
  # --     									local function wait_for_cc(attempts)
  # --     										if attempts <= 0 then return end
  # --     										if vim.fn.executable("cc") == 1 then
  # --     											for _, client in ipairs(vim.lsp.get_clients()) do
  # --     												vim.lsp.stop_client(client.id)
  # --     											end
  # --     											vim.defer_fn(function()
  # --     												vim.cmd("edit")
  # --     											end, 200)
  # --     										else
  # --     											vim.defer_fn(function()
  # --     												wait_for_cc(attempts - 1)
  # --     											end, 200)
  # --     										end
  # --     									end
  # --     									wait_for_cc(20)  -- try for up to 10 seconds
  # --     								end,
  # --     							})
  #   '';
  };
}
