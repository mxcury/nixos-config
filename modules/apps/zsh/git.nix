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
      enableDefaultConfig = false;
    
      settings = {
        "*" = {
          ForwardAgent = false;
          AddKeysToAgent = "no";
          Compression = false;
          ServerAliveInterval = 0;
          ServerAliveCountMax = 3;
          HashKnownHosts = false;
          UserKnownHostsFile = "~/.ssh/known_hosts";
          ControlMaster = "no";
          ControlPath = "~/.ssh/master-%r@%n:%p";
          ControlPersist = "no";
        };
    
        "github.com" = {
          HostName = "github.com";
          User = "git";
          IdentityFile = "~/.ssh/id_ed25519";
          IdentitiesOnly = true;
        };
      };
    };
  };
}
