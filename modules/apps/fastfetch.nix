{ self, inputs, ... }: {
  flake.homeModules.fastfetch = { pkgs, ... }: {
    programs.fastfetch = {
      enable = true;
      settings = {
        "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";

        logo = {
            source = "${./logo.txt}";
            type = "file";
            color = {
              "1" = "#F3A2BB";
              "2" = "#EEAE7B";
              "3" = "#B5C77D";
              "4" = "#6DD3C0";
              "5" = "#80C6F8";
              "6" = "#C7AFF5";
            };
          };

        display.separator = " ";

        modules = [
          { key = "╭──────────╮"; type = "custom"; }
          { key = "│ {#38;5;39} user   {#keys}│";  type = "title"; format = "{user-name}"; }
          { key = "│ {#38;5;208}󰇅 hname  {#keys}│"; type = "title"; format = "{host-name}"; }
          { key = "│ {#38;5;220}󰅐 uptime {#keys}│"; type = "uptime"; }
          { key = "│ {#38;5;51} distro {#keys}│";  type = "os"; }
          { key = "│ {#38;5;141} kernel {#keys}│"; type = "kernel"; }
          { key = "│ {#38;5;35}󰇄 wm     {#keys}│";  type = "wm"; }
          { key = "│ {#38;5;203} term   {#keys}│"; type = "terminal"; }
          { key = "│ {#38;5;75} shell  {#keys}│";  type = "shell"; }
          { key = "│ {#38;5;213}󰍛 cpu    {#keys}│"; type = "cpu"; showPeCoreCount = true; }
          { key = "│ {#38;5;178}󰉉 disk   {#keys}│"; type = "disk"; folders = "/"; }
          { key = "│ {#38;5;120} memory {#keys}│"; type = "memory"; }
          { key = "│ {#38;5;81}󰩟 network{#keys}│"; type = "localip"; format = "{ipv4} ({ifname})"; }
          { key = "├──────────┤"; type = "custom"; }
          { key = "│ {#38;5;255} colors {#keys}│"; type = "colors"; symbol = "circle"; }
          { key = "╰──────────╯"; type = "custom"; }
        ];
      };
    };
  };
}
