{ self, inputs, ... }: {
  flake.homeModules.lf = { pkgs, lib, ... }: {
    xdg.configFile."lf/icons".source = ./icons;

    home.packages = with pkgs; [
      pistol
      chafa
      file
      xdragon
    ];

    programs.lf = {
      enable = true;

      commands = {
        dragon-out = ''%${lib.getExe' pkgs.xdragon "xdragon"} -a "$fx"'';
        editor-open = ''$$EDITOR $f'';
        mkdir = ''
          ${"$"}{{
            printf "Directory Name: "
            read DIR
            mkdir $DIR
          }}
        '';
      };

      keybindings = {
        "\\\"" = "";
        o = "";
        c = "mkdir";
        "." = "set hidden!";
        "`" = "mark-load";
        "\\'" = "mark-load";
        "<enter>" = "open";

        do = "dragon-out";

        "g~" = "cd";
        gh = "cd";
        "g/" = "/";

        ee = "editor-open";
        V = ''$${lib.getExe pkgs.bat} --paging=always --theme=gruvbox "$f"'';
      };

      settings = {
        preview = true;
        hidden = true;
        drawbox = true;
        icons = true;
        ignorecase = true;
      };

      extraConfig =
        let
          previewer = pkgs.writeShellScriptBin "pv.sh" ''
            file=$1
            w=$2
            h=$3

            if [[ "$(${lib.getExe pkgs.file} -Lb --mime-type "$file")" =~ ^image ]]; then
              ${lib.getExe pkgs.chafa} --size="''${w}x''${h}" --animate=false "$file"
              exit 0
            fi

            ${lib.getExe pkgs.pistol} "$file"
          '';
        in
        ''
          set previewer ${previewer}/bin/pv.sh
        '';
    };
  };
}
