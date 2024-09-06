{ config, ... }:

{
  programs.bash = {
    enable = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      dotgit = "git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME";
      zj = "zellij";
    };

    history = {
      size = 1000;
      path = "${config.xdg.dataHome}/zsh/history";
    };

    initExtra = ''
      source ~/.config/zsh/extra.sh
    '';
  };

  programs.starship = {
    enable = true;
  };
}
