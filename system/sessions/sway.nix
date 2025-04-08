{
  bifrost,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;
  cfg = bifrost.sessions.sway;
in {
  config = mkIf cfg.enable {
    programs.sway = {
      enable = true;
      package = pkgs.swayfx;
      xwayland.enable = true;
    };
  };
}
