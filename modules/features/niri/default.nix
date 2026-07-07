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

        # 1. Global Blur Settings (Standard single-value nodes, serializes perfectly)
        blur = {
          passes = 3;
          offset = 3.0;
          noise = 0.02;
          saturation = 1.2;
        };

        # 2. Clean Layout, Gaps, and Solid Aesthetic Focus Rings
        # Removed the 'border' block entirely so it safely defaults to off.
        layout = {
          gaps = 12; 
          
          focus-ring = {
            width = 2;
            active-color = "#cba6f7";   # Gorgeous solid pastel lavender
            inactive-color = "#1e1e2e"; # Deep dark slate for unfocused windows
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

        # 4. Window Rules (Global Rounding + Terminal Blur)
        window-rule = [
          {
            # Global corner rounding & window content clipping
            geometry-corner-radius = 12;
            clip-to-geometry = true;
          }
          {
            # Target Rule: Transparent glassmorphism for Alacritty terminal
            match.app-id = "^Alacritty$";
            opacity = 0.85;
            background-effect = {
              blur = true;
              xray = true; # Highly efficient wallpaper blur caching
            };
          }
        ];

        binds = import ./_binds.nix { inherit lib pkgs self'; };
      };
    };
  };
}
