{ pkgs, inputs, ... }:

{
  # https://github.com/nix-community/home-manager/pull/2408
  environment.pathsToLink = [ "/share/fish" ];

  # Add ~/.local/bin to PATH
  environment.localBinInPath = true;

  # Since we're using fish as our shell
  programs.fish.enable = true;

  users.users.zebradil = {
    isNormalUser = true;
    home = "/home/zebradil";
    extraGroups = [
      "docker"
      "lxd"
      "wheel"
    ];
    shell = pkgs.fish;
    hashedPassword = "$2b$05$M.XpEndq4Trc0iGY53ZPmelrXOrusVg2jc84vRqPMXqmj1g604okq";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGbTIKIPtrymhvtTvqbU07/e7gyFJqNS4S0xlfrZLOaY mitchellh"
    ];
  };

  nixpkgs.overlays = import ../../lib/overlays.nix ++ [
    (import ./vim.nix { inherit inputs; })
  ];
}
