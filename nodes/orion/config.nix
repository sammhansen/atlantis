{...}: {
  imports = [
    ./default.nix
    ../../modules/orion/default.nix
  ];

  nixpkgs.config.allowUnfree = true;
  #nixpkgs.config.allowUnsupportedSystem = true;

  users = {
    mutableUsers = true;
  };

  system.stateVersion = "24.11";
}
