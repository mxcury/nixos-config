{ self, inputs, ... }: {
  flake.homeModules.zsh = { pkgs, ... }: {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = import ./aliases.nix;
    };

    programs.starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        "$schema" = "https://starship.rs/config-schema.json";
        add_newline = true;
        command_timeout = 1000;
        scan_timeout = 30;

        aws.disabled = true;
        gcloud.disabled = true;

        # Left side: pure-style path + git info + arrow
        format = "$username$hostname$directory$git_branch$git_state$git_status$line_break$python$character";

        # Right side: cmd duration, battery, clock
        right_format = "$cmd_duration$battery$time";

        directory.style = "blue";

        character = {
          success_symbol = "[❯](purple)";
          error_symbol = "[❯](red)";
          vimcmd_symbol = "[❮](green)";
        };

        git_branch = {
          symbol = " ";
          format = "[$symbol$branch]($style)";
          style = "bright-black";
        };

        git_status = {
          format = "[[(*$conflicted$untracked$modified$staged$renamed$deleted)](218) ($ahead_behind$stashed)]($style)";
          style = "cyan";
        };

        git_state = {
          format = "([$state( $progress_current/$progress_total)]($style)) ";
          style = "bright-black";
        };

        cmd_duration = {
          min_time = 2000;
          format = "[$duration]($style) ";
          style = "yellow";
        };

        time = {
          disabled = false;
          format = "[ $time]($style) ";
          time_format = "%R";
          style = "bright-black";
        };

        battery = {
          full_symbol = "󰁹 ";
          charging_symbol = "󰂄 ";
          discharging_symbol = "󰂃 ";
          unknown_symbol = "󰂑 ";
          empty_symbol = "󰂎 ";
          format = "[$symbol$percentage]($style) ";
          display = [
            {
              threshold = 100;
              style = "bold green";
            }
          ];
        };
      };
    };
  };
}
