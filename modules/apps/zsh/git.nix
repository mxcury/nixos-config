{ self, inputs, ... }: {
  flake.homeModules.git = { pkgs, config, ... }: {
    programs.git = {
      enable = true;

      settings = {
        user = {
          name = "mxcury";
          email = "mxcury.dev@proton.me";
        };

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

      signing = {
        key = "~/.ssh/id_ed25519.pub";
        signByDefault = true;
      };
    };

    programs.delta = {
      enable = true;
      enableGitIntegration = true;
      options = {
        navigate = true;
        line-numbers = true;
        side-by-side = false;
      };
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
