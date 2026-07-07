{ self, inputs, ... }: {
  perSystem = { pkgs, ... }: {
    packages.noctalia-wrapped = inputs.wrapper-modules.wrappers.noctalia-shell.wrap {
      inherit pkgs;
      settings = {};
    };
  };
}
