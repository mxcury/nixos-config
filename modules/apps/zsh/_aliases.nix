{
  ll = "eza -l --icons --git --group-directories-first --header --total-size";
  la = "eza -la --icons --git --group-directories-first --header --total-size";

  lg = "lazygit";
  sys-upgrade = "cd $FLAKE && nix flake update && nh os switch --ask";

  cat = "bat -pp";
  find = "fd";
  grep = "rg";

  ".." = "cd ..";
  "..." = "cd ../..";
  "...." = "cd ../../..";
  "....." = "cd ../../../..";

  "--" = "cd --";

  mkdir = "mkdir -p";
  rmdir = "rm -rf";
}
