{ self, inputs, ... }: {
  flake.homeModules.spotify-player = { pkgs, ... }: {
    programs.spotify-player = {
      enable = true;
      settings = {
        playback_format = "{status} {track} • {artists} {liked}\n{album} • {genres}";
        device = {
          audio_cache = true;
          normalization = true;
        };
      };
    };
  };
}
