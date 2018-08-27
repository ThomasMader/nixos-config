{ pkgs, fetchgit }:

let
  buildVimPlugin = pkgs.vimUtils.buildVimPluginFrom2Nix;
in {

  "easybuffer" = buildVimPlugin {
    name = "easybuffer";
    src = fetchgit {
      url = "https://github.com/troydm/easybuffer.vim";
      rev = "9aa8e81c1a8f61d8b096098e880d91cdf839ff89";
      sha256 = "0681pjfndrknxlfrs0c9mc4kyzi01fqcaivlm49bcgppc80aa8j3";
    };
    dependencies = [];
  };

}
