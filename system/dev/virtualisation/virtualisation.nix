{
  bifrost,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;
  cfg = bifrost.virtualisation;
in {
  config = mkIf cfg.enable {
    virtualisation = {
      libvirtd.enable = true;
      lxd.enable = true;
    };

    environment.systemPackages = with pkgs; [
      distrobox
    ];
  };
}
