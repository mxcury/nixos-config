{ self, inputs, ... }: {
  flake.homeModules.git = { pkgs, config, ... }: {
    programs.git = {
      enable = true;
      userName = "mxcury";
      userEmail = "mxcury.dev@proton.me";

      # Use SSH for commit signing (git >= 2.34)
      signing = {
        key = "~/.ssh/id_ed25519.pub"; # <-- point this at your SSH public key
        signByDefault = true;
      };

      extraConfig = {
        init.defaultBranch = "main";

        pull.rebase = true;
        rebase.autoStash = true;
        push.autoSetupRemote = true;
        push.default = "current";

        fetch.prune = true;

        merge.conflictstyle = "diff3";
        diff.colorMoved = "default";

        core = {
          editor = "nvim";
          autocrlf = "input";
        };

        color.ui = "auto";

        gpg.format = "ssh";

        gpg.ssh.allowedSignersFile = "${config.home.homeDirectory}/.ssh/allowed_signers";

        credential.helper = "cache --timeout=3600";
      };

      delta = {
        enable = true;
        options = {
          navigate = true;
          line-numbers = true;
          side-by-side = false;
        };
      };

      ignores = [
        ".DS_Store"
        "*.swp"
        ".direnv/"
        "result"
      ];
    };

    programs.ssh = {
      enable = true;
      matchBlocks."github.com" = {
        identityFile = "~/.ssh/id_ed25519";
        identitiesOnly = true;
      };
    };
  };
}
