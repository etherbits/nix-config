{ pkgs, ... }:

{
  home =
    {
      packages = with pkgs; [
        iosevka
        noto-fonts-cjk-sans
        helvetica-neue-lt-std
        (nerdfonts.override {
          fonts = [ "Iosevka" ];
        })
      ];
    };


  fonts.fontconfig.enable = true;
}
