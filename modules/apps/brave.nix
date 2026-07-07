{ self, inputs, ...}: {
  flake.homeModules.brave = { pkgs, ...}: {
    programs.chromium = {
      enable = true;
      package = pkgs.brave;
      commandLineArgs = [
        "--force-dark-mode"
        "--enable-features=WebUIDarkMode"
      ];
      extraOpts = {
        "BraveAIChatEnabled" = false;
        "BraveWalletDisabled" = true;
        "BraveRewardsDisabled" = true;
        "BraveVPNDisabled" = true;
        "BraveNewsDisabled" = true;
      };

      extensions = [
        {id = "ghmbeldphafepmbegfdlkpapadhbakde"; } # Proton Pass
        {id = "epcnnfbjfcgphgdmggkamkmgojdagdnn"; } # UBlock Origin
        {id = "mnjggcdmjocbbbhaepdhchncahnbgone"; } # Sponsor Block
      ];
    };
  };

}
