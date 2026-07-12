{ self, inputs, ... }: {
  flake.homeModules.brave = { pkgs, ... }: {
    programs.chromium = {
      enable = true;
      package = pkgs.brave;

      commandLineArgs = [
        "--force-dark-mode"
        "--enable-features=WebUIDarkMode"
        "--ozone-platform-hint=wayland"
        "--no-first-run"
        "--no-default-browser-check"
        "--disable-background-networking"
        "--disable-component-update"
        "--disable-domain-reliability"
        "--disable-features=Translate,MediaRouter,OptimizationHintsFetching"
      ];

      extensions = [
        { id = "ghmbeldphafepmbegfdlkpapadhbakde"; } # Proton Pass
        { id = "epcnnfbjfcgphgdmggkamkmgojdagdnn"; } # UBlock Origin
        { id = "mnjggcdmjocbbbhaepdhchncahnbgone"; } # SponsorBlock
      ];
    };
  };
}
