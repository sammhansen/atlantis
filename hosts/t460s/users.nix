{
  pkgs,
  username,
  ...
}: let
  inherit (import ./variables.nix) gitUsername;
in {
  users = {
    users."${username}" = {
      homeMode = "755";
      isNormalUser = true;
      description = "${gitUsername}";
      shell = pkgs.nushell;
      extraGroups = [
        "networkmanager"
        "wheel"
        "libvirtd"
        "scanner"
        "lp"
        "video"
        "input"
        "audio"
        "docker"
        "wireshark"
        "dialout"
        "fingerprint"
        "plugdev"
      ];
    };

    # create groups that arent created
    groups = {
      scanner = {};
      libvirtd = {};
      wireshark = {};
      dialout = {};
      fingerprint = {};
      plugdev = {};
    };

    defaultUserShell = pkgs.nushell;
  };

  environment.shells = with pkgs; [
    fish
    nushell
  ];

  programs.fish.enable = true;
}
