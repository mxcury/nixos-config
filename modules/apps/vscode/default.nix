{ self, inputs, ... }: {
  flake.homeModules.vscodium = { pkgs, ... }:
    let
      vscode-extensions = inputs.nix-vscode-extensions.extensions.${pkgs.system};
    in
    {
      programs.vscodium = {
        enable = true;

        profiles.default = {
          extensions = (with pkgs.vscode-extensions; [
            jnoortheen.nix-ide
          ]) ++ (with vscode-extensions.vscode-marketplace; [
            # esbenp.prettier-vscode
            # rust-lang.rust-analyzer
          ]) ++ (with vscode-extensions.open-vsx; [
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
