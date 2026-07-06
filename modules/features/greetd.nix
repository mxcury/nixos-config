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
          command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --remember-session --asterisks --greeting \"${config.system.nixos.release}\" --theme \"title=magenta;greet=light_blue;border=light_magenta;text=white;prompt=cyan;input=light_cyan;action=blue;button=light_blue\"--cmd niri";
        };
      };
    };
  };
}
