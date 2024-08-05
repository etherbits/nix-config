{ ... }:

{
  programs.kitty = {
    enable = true;
    theme = "Kanagawa_dragon";
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
}
