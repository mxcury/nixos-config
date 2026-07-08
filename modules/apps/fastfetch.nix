{ self, inputs, ... }: {
  flake.homeModules.fastfetch = { pkgs, ... }: {
    programs.fastfetch = {
      enable = true;
      settings = {
        "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";

        logo = {
          type = "small";
          padding.top = 1;
        };

        display = {
          separator = " {#keys}│ ";
          key.width = 12;
        };

        modules = [
          { key = "╭─────────────╮"; type = "custom"; }
          { key = "│ {#31} user"; type = "title"; format = "{user-name}"; }
          { key = "│ {#32}󰇅 hname"; type = "title"; format = "{host-name}"; }
          { key = "│ {#33}󰅐 uptime"; type = "uptime"; }
          { key = "│ {#34}{icon} distro"; type = "os"; }
          { key = "│ {#35} kernel"; type = "kernel"; }
          { key = "│ {#36}󰇄 desktop"; type = "de"; }
          { key = "│ {#31} term"; type = "terminal"; }
          { key = "│ {#32} shell"; type = "shell"; }
          { key = "│ {#33}󰍛 cpu"; type = "cpu"; showPeCoreCount = true; }
          { key = "│ {#34}󰉉 disk"; type = "disk"; folders = "/"; }
          { key = "│ {#35} memory"; type = "memory"; }
          { key = "│ {#36}󰩟 network"; type = "localip"; format = "{ipv4} ({ifname})"; }
          { key = "├─────────────┤"; type = "custom"; }
          { key = "│ {#39} colors"; type = "colors"; symbol = "circle"; }
          { key = "╰─────────────╯"; type = "custom"; }
        ];
      };
    };
  };
}
