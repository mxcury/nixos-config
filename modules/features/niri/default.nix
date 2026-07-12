{ self, inputs, ... }: {
  flake.nixosModules.niri =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      programs.niri = {
        enable = true;
        package = self.packages.${pkgs.stdenv.hostPlatform.system}.niri-wrapped;
      };
    };

  perSystem =
    {
      pkgs,
      lib,
      self',
      ...
    }:
    {
      packages.niri-wrapped = inputs.wrapper-modules.wrappers.niri.wrap {
        inherit pkgs;
        settings = {
          spawn-at-startup = [
            (lib.getExe self'.packages.noctalia-wrapped)
          ];

          environment."LIBGL_ALWAYS_SOFTWARE" = "1";
          xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;
          input = {
            keyboard.xkb.layout = "gb,us";
            touchpad = {
              tap = _: { };
              natural-scroll = _: { };
              click-method = "clickfinger";
            };
          };
          hotkey-overlay.skip-at-startup = true;

          blur = {
            passes = 3;
            offset = 3.0;
            noise = 0.02;
            saturation = 1.2;
          };

          layout = {
            gaps = 12;
          };

          animations = {
            window-open = {
              duration-ms = 200;
              curve = "ease-out-expo";
            };

            window-close = {
              duration-ms = 150;
              curve = "ease-out-quad";
            };
          };

          window-rule = [
            {
              geometry-corner-radius = 12;
              clip-to-geometry = true;
            }
          ];

          binds = import ./_binds.nix { inherit lib pkgs self'; };
        };
      };
    };
}
