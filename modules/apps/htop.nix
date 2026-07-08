{ self, inputs, ... }: {
  flake.homeModules.htop = { pkgs, ... }: {
    programs.htop = {
      enable = true;
      settings = {
        sort_key = "PERCENT_CPU";
        sort_direction = "descending";
        hide_kernel_threads = true;
        tree_view = true;
      };
    };
  };
}
