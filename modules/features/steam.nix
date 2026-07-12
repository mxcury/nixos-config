{ self, inputs, ... }: {
  flake.nixosModules.steam = { pkgs, ... }: {

    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
      remotePlay.openFirewall = true;
    };

    programs.gamemode.enable = true;
  };
}
