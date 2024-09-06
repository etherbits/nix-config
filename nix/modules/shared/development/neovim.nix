{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;

    extraPackages = with pkgs; [
      # Runtime dependendies
      gnumake
      gcc
      luajit

      # Language servers
      lua-language-server
      nil
      nixd
      marksman

      # Formatters
      nixpkgs-fmt
      stylua

      # Linters
      markdownlint-cli

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
