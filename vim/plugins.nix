{ pkgs, fetchgit }:

let
  buildVimPlugin = pkgs.vimUtils.buildVimPluginFrom2Nix;
in {

  "vim-smooth-scroll" = buildVimPlugin {
    name = "vim-smooth-scroll";
    src = fetchgit {
      url = "https://github.com/terryma/vim-smooth-scroll";
      rev = "0eae2367c70c3415b97869346af1b5e30c123dff";
      sha256 = "05sz25ci2f0qh6mfv51hs3j0sl9dr1k1278anf1a4gjigiap01pw";
    };
    dependencies = [];
  };

}
