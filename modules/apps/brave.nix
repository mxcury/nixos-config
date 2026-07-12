{ self, inputs, ... }: {
  flake.homeModules.brave = { pkgs, ... }: {
    programs.chromium = {
      enable = true;
      package = pkgs.brave;

      commandLineArgs = [
        "--force-dark-mode"
        "--enable-features=WebUIDarkMode"

        "--ozone-platform-hint=wayland"

        # skip startup work you don't need
        "--no-first-run"
        "--no-default-browser-check"
        "--disable-background-networking"
        "--disable-component-update"
        "--disable-domain-reliability"
        "--disable-features=Translate,MediaRouter,OptimizationHintsFetching"
      ];

      extraOpts = {
        "RestoreOnStartup" = 5; # 5 = open to new tab page, 1 = restore previous session
        "DefaultBrowserSettingEnabled" = false;
        "MetricsReportingEnabled" = false;
      };

      extensions = [
        { id = "ghmbeldphafepmbegfdlkpapadhbakde"; } # Proton Pass
        { id = "epcnnfbjfcgphgdmggkamkmgojdagdnn"; } # UBlock Origin
        { id = "mnjggcdmjocbbbhaepdhchncahnbgone"; } # SponsorBlock
      ];
    };
  };
}
