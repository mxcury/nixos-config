{ self, inputs, ... }: {
  flake.homeModules.fzf = { pkgs, lib, ... }: {
    programs.fzf = {
      enable = true;
      enableZshIntegration = true;

      defaultCommand = "${lib.getExe pkgs.fd} --type f --hidden --exclude .git";
      defaultOptions = [
        "--height 40%"
        "--layout=reverse"
        "--border"
        "--preview '${lib.getExe pkgs.bat} --color=always --style=numbers --line-range=:200 {}'"
        "--preview-window=right:50%"
      ];

      fileWidget = {
        command = "${lib.getExe pkgs.fd} --type f --hidden --exclude .git";
        options = [
          "--preview '${lib.getExe pkgs.bat} --color=always --style=numbers --line-range=:200 {}'"
        ];
      };

      changeDirWidget = {
        command = "${lib.getExe pkgs.fd} --type d --hidden --exclude .git";
        options = [
          "--preview '${lib.getExe pkgs.eza} --tree --color=always {} | head -200'"
        ];
      };
    };
  };
}
