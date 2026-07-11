{ self, inputs, ... }: {
  flake.homeModules.vscodium = { pkgs, ... }:
    let
      vscode-extensions = inputs.nix-vscode-extensions.extensions.${pkgs.system};
    in
    {
      programs.vscode = {
        enable = true;
        package = pkgs.vscodium;

        profiles.default = {
          extensions = (with pkgs.vscode-extensions; [
            jnoortheen.nix-ide
          ]) ++ (with vscode-extensions.vscode-marketplace; [
            # pull extensions from the marketplace mirror here, e.g.:
            # esbenp.prettier-vscode
            # rust-lang.rust-analyzer
          ]) ++ (with vscode-extensions.open-vsx; [
            # or from open-vsx if marketplace doesn't have one, e.g.:
            # some.publisher-name
          ]);

          userSettings = {
            "editor.fontSize" = 14;
            "workbench.colorTheme" = "Default Dark+";
            "telemetry.telemetryLevel" = "off";
            "update.mode" = "none";
            "extensions.autoUpdate" = false;
          };
        };
      };
    };
}
