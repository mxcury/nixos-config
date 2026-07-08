{ lib, pkgs, self' }: {
  ### Apps ###
  "Mod+Return".spawn-sh = lib.getExe pkgs.alacritty;
  "Mod+B".spawn-sh = lib.getExe pkgs.brave;
  "Mod+Q".close-window = _: { };
  "Mod+Space".spawn-sh = "${lib.getExe self'.packages.noctalia-wrapped} ipc call launcher toggle";
  
  ### Focus movement (arrows) ###
  "Mod+Left".focus-column-left = { };
  "Mod+Right".focus-column-right = { };
  "Mod+Down".focus-window-down = { };
  "Mod+Up".focus-window-up = { };

  ### Focus movement (vim-style HJKL, mirrors arrows) ###
  "Mod+H".focus-column-left = { };
  "Mod+L".focus-column-right = { };
  "Mod+J".focus-window-down = { };
  "Mod+K".focus-window-up = { };

  ### Move windows/columns ###
  "Mod+Ctrl+Left".move-column-left = { };
  "Mod+Ctrl+Right".move-column-right = { };
  "Mod+Ctrl+Down".move-window-down = { };
  "Mod+Ctrl+Up".move-window-up = { };
  
  ### Move windows/columns (vim-style HJKL, mirrors arrows) ###
  "Mod+Ctrl+H".move-column-left = { };
  "Mod+Ctrl+L".move-column-right = { };
  "Mod+Ctrl+J".move-window-down = { };
  "Mod+Ctrl+K".move-window-up = { };
  
  ### Workspaces (scroll-style) ###
  "Mod+Page_Down".focus-workspace-down = { };
  "Mod+Page_Up".focus-workspace-up = { };
  "Mod+Ctrl+Page_Down".move-column-to-workspace-down = { };
  "Mod+Ctrl+Page_Up".move-column-to-workspace-up = { };
  
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
    
  ### Session / system ###
  #"Mod+Shift+E".quit = { };
  #"Mod+Escape".toggle-keyboard-shortcuts-inhibit = { allow-inhibiting = false; };
}
