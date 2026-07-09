{ _self, _inputs, ... }: {
  flake.homeModules.niriCursor = { pkgs, ... }: {
    home.pointerCursor = {
      enable = true;
      gtk.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };
  };
}
