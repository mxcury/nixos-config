{
  lib,
  pkgs,
  self',
}:
let
  noctalia = lib.getExe self'.packages.noctalia-wrapped;
in
{
  ### Apps ###
  "Mod+Return".spawn-sh = lib.getExe pkgs.alacritty;
  "Mod+B".spawn-sh = lib.getExe pkgs.brave;
  "Mod+Q".close-window = _: { };
  "Mod+Space".spawn-sh = "${noctalia} ipc call launcher toggle";
  "Mod+Tab".toggle-overview = { };

  ### Focus movement (arrows) ###
  "Mod+Left".focus-column-left = { };
  "Mod+Right".focus-column-right = { };

  ### Focus movement (vim-style HJKL, mirrors arrows) ###
  "Mod+H".focus-column-left = { };
  "Mod+L".focus-column-right = { };
  "Mod+J".focus-window-down = { };
  "Mod+K".focus-window-up = { };

  ### Move windows/columns ###
  "Mod+Shift+Left".move-column-left = { };
  "Mod+Shift+Right".move-column-right = { };

  ### Move windows/columns (vim-style HJKL, mirrors arrows) ###
  "Mod+Shift+H".move-column-left = { };
  "Mod+Shift+L".move-column-right = { };
  "Mod+Shift+J".move-window-down = { };
  "Mod+Shift+K".move-window-up = { };

  ### Workspaces (scroll-style) ###
  "Mod+Down".focus-workspace-down = { };
  "Mod+Up".focus-workspace-up = { };
  "Mod+Shift+Down".move-column-to-workspace-down = { };
  "Mod+Shift+Up".move-column-to-workspace-up = { };

  ### Workspaces (numbered, i3-style, added on top) ###
  "Mod+1".focus-workspace = 1;
  "Mod+2".focus-workspace = 2;
  "Mod+3".focus-workspace = 3;
  "Mod+4".focus-workspace = 4;
  "Mod+5".focus-workspace = 5;
  "Mod+6".focus-workspace = 6;
  "Mod+Shift+1".move-column-to-workspace = 1;
  "Mod+Shift+2".move-column-to-workspace = 2;
  "Mod+Shift+3".move-column-to-workspace = 3;
  "Mod+Shift+4".move-column-to-workspace = 4;
  "Mod+Shift+5".move-column-to-workspace = 5;
  "Mod+Shift+6".move-column-to-workspace = 6;

  ### Window / Column sizing ###
  "Mod+R".switch-preset-column-width = { };
  "Mod+F".maximize-column = { };
  "Mod+Shift+F".fullscreen-window = { };
  "Mod+C".center-column = { };

  ### Screenshots ###
  "Print".screenshot = { };
  "Ctrl+Print".screenshot-screen = { };
  "Alt+Print".screenshot-window = { };

  ## Shortcuts ###
  "XF86AudioRaiseVolume".spawn-sh = "${noctalia} ipc call volume increase";
  "XF86AudioLowerVolume".spawn-sh = "${noctalia} ipc call volume decrease";
  "XF86AudioMute".spawn-sh = "${noctalia} ipc call volume muteOutput";
  "XF86AudioMicMute".spawn-sh = "${noctalia} ipc call volume muteInput";

  "XF86MonBrightnessUp".spawn-sh = "${noctalia} ipc call brightness increase";
  "XF86MonBrightnessDown".spawn-sh = "${noctalia} ipc call brightness decrease";

  "XF86Bluetooth".spawn-sh = "${noctalia} ipc call bluetooth toggle";
  "XF86WLAN".spawn-sh = "${noctalia} ipc call airplaneMode toggle";

  ### Session / system ###
  #"Mod+Shift+E".quit = { };
  #"Mod+Escape".toggle-keyboard-shortcuts-inhibit = { allow-inhibiting = false; };
}
