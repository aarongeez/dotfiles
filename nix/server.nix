{ pkgs, lib, ... }: {
  imports = [
    "/home/parth/dotfiles/nix/common/headless.nix"
  ];

  networking.hostName = "parth-server-nix";

  # Bootloader.
  boot.loader.grub = {
    enable = true;
    device = "/dev/nvme1n1";
    useOSProber = true;
  };

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "yes";
      PasswordAuthentication = true;
    };
  };

  systemd.services."getty@tty1".enable = false;

  services.github-runners.lockbook = {
    enable = true;
    name = "lockbook ci";
    user = "parth";
    extraLabels = [ "ci" ];
    tokenFile = "/home/parth/token";
    url = "https://github.com/lockbook/lockbook";
    extraPackages = with pkgs; [
      rustup
      gcc

      # pkg-config
      # gtk3
      # glib
      # gobject-introspection
      # gdk-pixbuf
      # pango
      # cairo
    ];
    serviceOverrides = {
      ProtectSystem = "no";
      ProtectHome = "no";
      PrivateTmp = false;
      PrivateDevices = false;
    };
    extraEnvironment = {
      NIX_PATH = "/nix/var/nix/profiles/per-user/root/channels/nixos";
      # PKG_CONFIG_PATH = lib.makeSearchPath "pkgconfig" [
      #   pkgs.gtk3.dev
      #   pkgs.glib.dev
      #   pkgs.gdk-pixbuf.dev
      #   pkgs.atk.dev
      #   pkgs.pango.dev
      #   pkgs.cairo.dev
      #   pkgs.gobject-introspection.dev
      # ];
    };
  };

  # environment.systemPackages = with pkgs; [
  #   (buildEnv {
  #     name = "ci-env";
  #     paths = [
  #       pkg-config
  #       gtk3
  #       glib
  #       gobject-introspection
  #       gdk-pixbuf
  #       atk
  #     ];
  #   })
  # ];
}
