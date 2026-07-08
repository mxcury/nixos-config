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

      fileWidgetCommand = "${lib.getExe pkgs.fd} --type f --hidden --exclude .git";
      fileWidgetOptions = [
        "--preview '${lib.getExe pkgs.bat} --color=always --style=numbers --line-range=:200 {}'"
      ];

      changeDirWidgetCommand = "${lib.getExe pkgs.fd} --type d --hidden --exclude .git";
      changeDirWidgetOptions = [
        "--preview '${lib.getExe pkgs.eza} --tree --color=always {} | head -200'"
      ];
    };
  };
}
