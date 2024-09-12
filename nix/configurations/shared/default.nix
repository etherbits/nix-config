{ pkgs, ... }:

{
  # Nix specific
  nix.settings.experimental-features = [ "nix-command" "flakes" ]; # add flakes
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.efiSupport = true;

  # Filesystem
  boot.supportedFilesystems = [ "ntfs" ];

  # Networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Tbilisi";
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  hardware.opengl.enable = true;

  # Hyrpland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services.xserver.displayManager.gdm.enable = true;
  services.displayManager.defaultSession = "hyprland";

  # Keyring
  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true;
  security.pam.services.gdm.enableGnomeKeyring = true;
  security.pam.services.gdm-password.enableGnomeKeyring = true;

  # Screen Lock
  security.pam.services.gtklock = { };

  # Enable sound.
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable zsh and set it as default
  programs.zsh.enable = true;
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;

  # Other system things
  services.gvfs.enable = true;
  security.polkit.enable = true;

  virtualisation.docker.enable = true;

  users.extraGroups.docker.members = [ "etherbits" ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.etherbits = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      git
      tree
      home-manager
    ];
    initialPassword = "initial";
  };


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
    kdeconnect
    wl-clipboard
    lutris
    wine
  ];

  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };

  # For installing packages from other sources
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;

  # Steam
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };


  programs.gamemode.enable = true;

  # Setting default browser
  xdg.mime.defaultApplications = {
    "text/html" = "firefox.desktop";
    "x-scheme-handler/http" = "firefox.desktop";
    "x-scheme-handler/https" = "firefox.desktop";
    "x-scheme-handler/about" = "firefox.desktop";
  };

  # Environment variables
  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/etherbits/.steam/root/compatailitytools.d";
    NIXOS_OZONE_WL = "1"; # This variable fixes electron apps in wayland
  };


  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # WARNING: Did you read the comment?
}
