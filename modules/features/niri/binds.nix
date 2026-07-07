{ lib, pkgs, self' }: {
  "Mod+Return".spawn-sh = lib.getExe pkgs.alacritty;
  "Mod+Q".close-window = _: { };
  "Mod+Space".spawn-sh = "${lib.getExe self'.packages.noctalia-wrapped} ipc call launcher toggle";
}
