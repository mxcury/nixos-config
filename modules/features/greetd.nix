{ self, input, ... }: {
  flake.nixosModules.greetd = {pkgs, config, lib, ... }: {
    imports = [
      self.nixosModules.niri
    ];

    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          user = "greeter";
          command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --remember-session --asterisks --greeting \"Running NixOS ${config.system.nixos.release}!\" --cmd niri";
        };
      };
    };
  };
}
