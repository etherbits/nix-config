{ pkgs, ... }:

{
  xdg.configFile.nvim.source = builtins.fetchGit {
    url = "https://github.com/etherbits/nvim";
    rev = "b98a8a2ed7601f277de6974720c1ff1bca082226";
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
