{ self, inputs, ...}: {
  flake.homeModules.brave = { pkgs, ...}: {
    programs.chromium = {
      enable = true;
      package = pkgs.brave;
      commandLineArgs = [
        "--force-dark-mode"
        "--enable-features=WebUIDarkMode,UseOzonePlatform"
	"--ozone-platform-hint=auto"
      ];

      extensions = [
        {id = "ghmbeldphafepmbegfdlkpapadhbakde"; } # Proton Pass
        {id = "epcnnfbjfcgphgdmggkamkmgojdagdnn"; } # UBlock Origin
        {id = "mnjggcdmjocbbbhaepdhchncahnbgone"; } # Sponsor Block
      ];
    };
  };

}
