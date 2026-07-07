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

        # 1. Global Blur Settings (Controls background blur intensity)
        blur = {
          passes = 3;       # Blur quality smoothness
          offset = 3.0;     # Blur radius spread per pass
          noise = 0.02;     # Dithering noise to prevent color banding
          saturation = 1.2; # Boost colors shining through the glass
        };

        # 2. Layout, Gaps, and Wallpaper-Themed Gradient Focus Rings
        layout = {
          gaps = 12; # Clean outer & inner spacing to let shadows breath
          
          focus-ring = {
            width = 2;
            # A gorgeous, vibrant pastel gradient (Lavender to Blue)
            active-gradient = {
              from = "#cba6f7";
              to = "#89b4fa";
              angle = 45;
            };
            inactive-color = "#1e1e2e"; # Deep dark slate for unfocused windows
          };
          
          border.enable = false; # Drop borders entirely; focus rings look cleaner
        };

        # 3. Clean, Fast Easing Animations
        animations = {
          window-open = {
            duration-ms = 200;       # Snappy 0.2 second pop in
            curve = "ease-out-expo"; # Blazing fast start, gentle deceleration
          };
          
          window-close = {
            duration-ms = 150;       # Lightning-fast 0.15 second close
            curve = "ease-out-quad"; # Predictable, smooth exit velocity
          };
        };

        # 4. Window Rules (Combining Global Rules + Terminal Blur)
        window-rule = [
          {
            # Global Rule: Applied to ALL windows
            geometry-corner-radius = 12;
            clip-to-geometry = true;
            shadow = {
              enable = true;
              softness = 30;
              spread = 2;
              offset = { x = 0; y = 6; };
              color = "#00000050"; # Elegant semi-transparent drop shadow
            };
          }
          {
            # Target Rule: Transparent glassmorphism for Alacritty terminal
            match.app-id = "^Alacritty$";
            opacity = 0.85;
            background-effect = {
              blur = true;
              xray = true; # Blurs wallpaper directly for major performance gains
            };
          }
        ];

        binds = import ./_binds.nix { inherit lib pkgs self'; };
      };
    };
  };
}
