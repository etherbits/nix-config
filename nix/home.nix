{ inputs, config, pkgs, lib, ...}: {
	home = {
		username = "etherbits";
		homeDirectory = "/home/etherbits";
		stateVersion = "24.05";

		packages = with pkgs; [
			iosevka
			(pkgs.nerdfonts.override { fonts = [ "Iosevka" ]; })
			neofetch
			htop
			git
			gh
			ags
			pavucontrol
			pamixer
			fzf
			ripgrep
			zellij
			feh
			mpv
			firefox
			google-chrome		
			spotify
			spicetify-cli
			appflowy
			todoist-electron
			obsidian
			jellyfin
			jellyfin-web
			jellyfin-mpv-shim
			playerctl
			anyrun
			gtklock
			figma-linux
			xdg-desktop-portal-hyprland
			
			#utils
			hyprpicker
			
			# for taking screenshots
			grim
			swappy
			slurp

			# for testing
			xorg.xeyes # test xwayland
		];
	};						

	wayland.windowManager.hyprland = {
		enable = true;
		package = pkgs.hyprland;
		xwayland.enable = true;
		systemd.enable = true;
	};

	wayland.windowManager.hyprland.settings = {
		monitor = "eDP-1,1920x1080@60,0x0,1";
		"$mod" = "SUPER";

		general = {
			gaps_in = 6;
			gaps_out = 12;

			border_size = 1;
			"col.active_border" = "rgba(7aa2f7ee) rgba(7aa2f766) 45deg";
		};

		decoration = {
			    rounding = 6;

			    # Change transparency of focused and unfocused windows
			    active_opacity = 1.0;
			    inactive_opacity = 1.0;

			    drop_shadow = true;
			    shadow_range = 4;
			    shadow_render_power = 3;
			    "col.shadow" = "rgba(1a1a1aee)";

			    # https://wiki.hyprland.org/Configuring/Variables/#blur
			    blur = {
				enabled = true;
				size = 5;
				passes = 3;

				
				vibrancy = 0.1696;
			    };
		};

		animations = {
			    enabled = true;

			    bezier = [ 
				"myBezier, 0.05, 0.9, 0.1, 1.05"
			    	"linear, 0.0, 0.0, 1.0, 1"
			    ];

			    animation = [
				"windows, 1, 2, myBezier"
				"windowsOut, 1, 2, default, popin 80%"
				"border, 1, 2, default"
				"borderangle, 1, 2, default"
				"fade, 1, 2, default"
				"workspaces, 1, 2, default"
			 	"borderangle, 1, 50, linear, loop"
			    ];
		};
		
		bind = 
			[
				"$mod, RETURN, exec, kitty"
				"$mod, B, exec, firefox"
				"$mod, Q, killactive"
				"$mod, F, togglefloating"
				# Move focus with mainMod + arrow keys
				"$mod, h, movefocus, l"
				"$mod, l, movefocus, r"
				"$mod, k, movefocus, u"
				"$mod, j, movefocus, d"

				# Move window
				"$mod SHIFT, h, movewindow, l"
				"$mod SHIFT, l, movewindow, r"
				"$mod SHIFT, k, movewindow, u"
				"$mod SHIFT, j, movewindow, d"

				# Resize
				"$mod CTRL, H, resizeactive,-200 0"
				"$mod CTRL, L, resizeactive,200 0 "
				"$mod CTRL, K, resizeactive,0 -200"
				"$mod CTRL, J, resizeactive,0 200 "

				# Switch workspaces with mainMod + [0-9]
				"$mod, 1, workspace, 1"
				"$mod, 2, workspace, 2"
				"$mod, 3, workspace, 3"
				"$mod, 4, workspace, 4"
				"$mod, 5, workspace, 5"
				"$mod, 6, workspace, 6"
				"$mod, 7, workspace, 7"
				"$mod, 8, workspace, 8"
				"$mod, 9, workspace, 9"
				"$mod, 0, workspace, 10"

				# Move active window to a workspace with mainMod + SHIFT + [0-9]
				"$mod SHIFT, 1, movetoworkspace, 1"
				"$mod SHIFT, 2, movetoworkspace, 2"
				"$mod SHIFT, 3, movetoworkspace, 3"
				"$mod SHIFT, 4, movetoworkspace, 4"
				"$mod SHIFT, 5, movetoworkspace, 5"
				"$mod SHIFT, 6, movetoworkspace, 6"
				"$mod SHIFT, 7, movetoworkspace, 7"
				"$mod SHIFT, 8, movetoworkspace, 8"
				"$mod SHIFT, 9, movetoworkspace, 9"
				"$mod SHIFT, 0, movetoworkspace, 10"

				# Example special workspace (scratchpad)
				"$mod, M, togglespecialworkspace, magic"
				"$mod SHIFT, M, movetoworkspace, special:magic"

				# Scroll through existing workspaces with mainMod + scroll
				"$mod, mouse_down, workspace, e+1"
				"$mod, mouse_up, workspace, e-1"

				# Move/resize windows with mainMod + LMB/RMB and dragging
				"$mod, mouse:272, movewindow"

				
			];
	};

	fonts.fontconfig.enable = true;	
	
	programs.bash = {
		enable = true;
	};

	programs.zsh = {
		enable = true;
		enableCompletion = true;
		autosuggestion.enable = true;
		syntaxHighlighting.enable = true;

		shellAliases = {
			rebuild-nixos = "sudo nixos-rebuild switch --flake ~/nix/";
			rebuild-home = "home-manager switch --flake ~/nix/";
			dotgit="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME";
		};
		
		history = {
			size = 1000;	
			path = "${config.xdg.dataHome}/zsh/history";
		};
	};

	programs.starship = {
		enable = true;
	};

	programs.kitty = {
		enable = true;
		theme = "Tokyo Night";
		shellIntegration = {
			enableZshIntegration = true;
			enableBashIntegration = true;
		};		
		font = {
			name = "iosevka";
			size = 12;
		};
		settings = {
			background_opacity = "0.85";
			enable_audio_bell = "no";	
		};
	};

	xdg.configFile.neovim.source = builtins.fetchGit { 
		url = "https://github.com/etherbits/nvim";
		rev = "a7f7fdc125bdd8a43d39386522a2ac42e53a9009";
	};

	programs.neovim = {
		enable = true;
		defaultEditor = true;
		vimAlias = true;
		viAlias = true;

		plugins = with pkgs.vimPlugins; [
			gruvbox-material
		];

		extraPackages = with pkgs; [
		      # Runtime dependendies
		      gnumake
		      gcc
		      luajit

		      # Language servers
		      lua-language-server
		      nil
		      nixd

		      # Formatters
		      nixpkgs-fmt
		      stylua

		      # NOTE: These 'extra' lsp and formatters should be installed on a
		      # per-project basis using nix shell

		      # clang-tools
		      # ltex-ls
		      # omnisharp-roslyn
		      # matlab-language-server
		      # prettierd
		      # black
		];
	};

}

