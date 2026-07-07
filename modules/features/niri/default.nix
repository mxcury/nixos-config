{ self, inputs, ... }: {
  flake.nixosModules.niri = { pkgs, lib, ... }: {
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.niri-wrapped;
    };
  };

  perSystem = { pkgs, lib, self', ... }: {
    packages.niri-wrapped = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs;
      settings = {
        spawn-at-startup = [
          (lib.getExe self'.packages.noctalia-wrapped)
        ];

        environment."LIBGL_ALWAYS_SOFTWARE" = "1";
        xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;
        input.keyboard.xkb.layout = "us,ua";
        hotkey-overlay.skip-at-startup = true;

        # 1. Global Blur Settings
        blur = {
          passes = 3;
          offset = 3.0;
          noise = 0.02;
          saturation = 1.2;
        };

        # 2. Layout, Gaps, and Wallpaper-Themed Gradient Focus Rings
        layout = {
          gaps = 12; 
          
          focus-ring = {
            width = 2;
            # FIX: Using 'props' forces these to render inline as Niri expects
            active-gradient = _: {
              props = {
                from = "#cba6f7";
                to = "#89b4fa";
                angle = 45;
              };
            };
            inactive-color = "#1e1e2e";
          };
        };

        # 3. Clean, Fast Easing Animations
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

        # 4. Window Rules (Combining Global Rules + Terminal Blur)
        window-rule = [
          {
            # Global Rule: Applied to ALL windows
            geometry-corner-radius = 12;
            clip-to-geometry = true;
          }
          {
            # FIX: Using 'props' here prevents the unexpected node 'app-id' error
            match = _: {
              props = {
                app-id = "^Alacritty$";
              };
            };
            opacity = 0.85;
            background-effect = {
              blur = true;
              xray = true;
            };
          }
        ];

        binds = import ./_binds.nix { inherit lib pkgs self'; };
      };
    };
  };
}
