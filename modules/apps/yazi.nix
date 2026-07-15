{ self, inputs, ... }: {
  flake.homeModules.yazi = { pkgs, ... }: {
    programs.yazi = {
      enable = true;
      enableZshIntegration = true;

      settings = {
        mgr = {
          show_hidden = true;
          sort_by = "natural";
          sort_dir_first = true;
        };
        preview = {
          max_width = 1200;
          max_height = 1200;
        };
      };

      plugins = {
        mount = inputs.yazi-plugins + "/mount.yazi";
      };

      keymap = {
        mgr.prepend_keymap = [
          {
            on = [
              "g"
              "h"
            ];
            run = "cd ~";
            desc = "Go home";
          }
          {
            on = [ "M" ];
            run = "plugin mount";
            desc = "Mount/unmount/eject disks";
          }
        ];
      };
    };

    # Überzug++ is required for image previews in Alacritty on Wayland/X11 —
    # Alacritty has no native Kitty/Sixel graphics protocol, so yazi falls
    # back to overlaying images via the window system.
    home.packages = with pkgs; [
      ueberzugpp
      ffmpegthumbnailer
      poppler-utils
      unar
      jq
      udisks2 # provides udisksctl, used by the mount plugin
      util-linux # provides lsblk (usually already present, but explicit is fine)
    ];

    home.sessionVariables = {
      YAZI_FILE_ONE = "${pkgs.file}/bin/file";
    };
  };
}
