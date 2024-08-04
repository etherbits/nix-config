{ pkgs, ... }:

{
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
