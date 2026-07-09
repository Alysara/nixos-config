{ pkgs, ... }:

{
  home.packages = with pkgs; [
    xdg-desktop-portal-termfilechooser
  ];

	programs.yazi = {
	  enable = true;
	  settings = {
	    opener = {
	      hx = [
	        { run = "hx \"$@\""; desc = "Helix"; block = true; }
	      ];
	      nvim = [
	        { run = "nvim \"$@\""; desc = "Neovim"; block = true; }
	      ];
	      zen = [
	        { run = "zen \"$@\""; desc = "Zen Browser"; }
	      ];
	    };
	    open = {
	      prepend_rules = [
	        {
	          mime = "text/html";
	          use = "zen";
	        }
          {
            url = "*.ts";
            use = "nvim";
          }
          {
            url = "*.tsx";
            use = "nvim";
          }
	        {
	          mime = "text/*";
	          use = "nvim";
	        }
	      ];
	    };
	  };
	};

  catppuccin.yazi.enable = true;

  # xdg.configFile."mimeapps.list".force = true;
  xdg.configFile."xdg-desktop-portal-termfilechooser/config" = {
    force = true;
    # enable = true;
    text = ''
      [filechooser]
      cmd=${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
      default_dir=$HOME
      open_mode=last
      save_mode=last
    '';
    recursive = true;
  };
}
